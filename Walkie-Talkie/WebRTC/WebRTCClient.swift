//
//  WebRTCService.swift
//  WebRTC
//
//  Created by Zaporozhchenko Oleksandr on 4/25/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC


final class WebRTCClient: NSObject {
    
    private static let factory: RTCPeerConnectionFactory = {
        RTCInitializeSSL()
        let videoEncoderFactory = RTCDefaultVideoEncoderFactory()
        let codec = RTCVideoCodecInfo(name: "VP8") // this is coz ios 13.3.1 screen is red
        videoEncoderFactory.preferredCodec = codec
        let videoDecoderFactory = RTCDefaultVideoDecoderFactory()
        videoDecoderFactory.createDecoder(codec)
        return RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
    }()
    
    weak var delegate: WebRTCClientDelegate?
    
    var peerConnection: RTCPeerConnection!
    let rtcAudioSession = RTCAudioSession.sharedInstance()
    private let mediaConstrains = [kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                                   kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue]
    private var videoCapturer: RTCVideoCapturer?
    private var localVideoTrack: RTCVideoTrack?
    private var localAudioTrack: RTCAudioTrack?
    private var remoteVideoTrack: RTCVideoTrack?
    
    private let config: RTCConfiguration!
    private let constraints = RTCMediaConstraints(optional: ["DtlsSrtpKeyAgreement": kRTCMediaConstraintsValueTrue])
    
    //MARK: - Initialize
    
    @available(*, unavailable)
    override init() {
        fatalError("WebRTCService init is unavailable")
    }
    
    convenience init(iceServers: [String]) {
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: iceServers)]
        config.sdpSemantics = .unifiedPlan
        config.continualGatheringPolicy = .gatherContinually
        self.init(config: config)
    }
    
    init(config: RTCConfiguration) {
        self.config = config
        super.init()
        createMediaSenders()
        configureAudioSession()
        startCall()
    }
    
    
    // MARK:- Signaling
    
    func offer(completion: @escaping (_ sdp: RTCSessionDescription) -> Void) {
        print("WebRTCClient offer")
        let constrains = RTCMediaConstraints(mandatoryConstraints: mediaConstrains, optionalConstraints: nil)
        
        peerConnection.offer(for: constrains) { sdp, error in
            guard let sdp = sdp else {
                print("WebRTCService offer no sdp, error ", error)
                return
            }
            
            self.peerConnection.setLocalDescription(sdp) { error in
                if let error = error  {
                    print("WebRTCService setLocalDescription error ", error)
                    return
                }
                completion(sdp)
            }
        }
    }
    
    func answer(completion: @escaping (_ sdp: RTCSessionDescription) -> Void)  {
        print("WebRTCClient answer")
        
        let constrains = RTCMediaConstraints(mandatoryConstraints: mediaConstrains, optionalConstraints: nil)
        
        peerConnection.answer(for: constrains) { sdp, error in
            guard let sdp = sdp else {
                print("WebRTCService answer no sdp ")
                return
            }
            
            self.peerConnection.setLocalDescription(sdp) { error in
                if let error = error  {
                    print("WebRTCService setLocalDescription error ", error)
                    return
                }
                completion(sdp)
            }
        }
    }
    
    func set(remoteSdp: RTCSessionDescription, completion: @escaping (Error?) -> ()) {
        peerConnection.setRemoteDescription(remoteSdp, completionHandler: completion)
    }
    
    func set(remoteCandidate: RTCIceCandidate) {
        peerConnection.add(remoteCandidate)
    }
    
    // MARK: - Media
    
    public func startCaptureLocalCameraVideo(renderer: RTCVideoRenderer) {
        print("startCaptureLocalCameraVideo")
        
        guard let capturer = videoCapturer as? RTCCameraVideoCapturer else {
            print("WebRTCService can't get capturer")
            return
        }
        
        guard
            let frontCamera = (RTCCameraVideoCapturer.captureDevices().first { $0.position == .front }),
            // choose highest res
            let format = (RTCCameraVideoCapturer.supportedFormats(for: frontCamera).sorted { (f1, f2) -> Bool in
                let width1 = CMVideoFormatDescriptionGetDimensions(f1.formatDescription).width
                let width2 = CMVideoFormatDescriptionGetDimensions(f2.formatDescription).width
                return width1 < width2
            }).last,
            
            // choose highest fps
            let fps = (format.videoSupportedFrameRateRanges.sorted { return $0.maxFrameRate < $1.maxFrameRate }.last)
            else {
                print("WebRTCService can't get frontCamera")
                return
        }
        
        capturer.startCapture(with: frontCamera,
                              format: format,
                              fps: Int(fps.maxFrameRate))
        
        localVideoTrack?.add(renderer)
    }
    
    public func startCaptureLocalVideoFile(name: String, renderer: RTCVideoRenderer) {
        print("startCaptureLocalVideoFile")
        
        guard let capturer = videoCapturer as? RTCFileVideoCapturer else {
            print("WebRTCService can't get capturer")
            return
        }
        
        capturer.startCapturing(fromFileNamed: name) { error in
            print("startCapturing error ", error)
            return
        }
        
        localVideoTrack?.add(renderer)
    }
    
    func renderRemoteVideo(to renderer: RTCVideoRenderer) {
        remoteVideoTrack?.add(renderer)
    }
    
    func startCall() {
        print("WebRTCService startCall")
        peerConnection = Self.factory.peerConnection(with: config, constraints: constraints, delegate: nil)
        let streamID = "stream"
        peerConnection.add(localAudioTrack!, streamIds: [streamID])
        peerConnection.add(localVideoTrack!, streamIds: [streamID])
        peerConnection.delegate = self
        
        remoteVideoTrack = peerConnection.transceivers
            .first { $0.mediaType == .video }?
            .receiver
            .track as? RTCVideoTrack
    }
    
    func hangup() {
        print("WebRTCService hangup")
        peerConnection.close()
    }
    
    //MARK: - Private
    
    private func configureAudioSession() {
        rtcAudioSession.lockForConfiguration()
        do {
            try rtcAudioSession.setCategory(AVAudioSession.Category.playAndRecord.rawValue)
            try rtcAudioSession.setMode(AVAudioSession.Mode.voiceChat.rawValue)
        } catch let error {
            debugPrint("WebRTCService Error changeing AVAudioSession category: \(error)")
        }
        
        rtcAudioSession.unlockForConfiguration()
    }
    
    private func createMediaSenders() {
        localAudioTrack = createAudioTrack()
        localVideoTrack = createVideoTrack()
    }
    
    private func createAudioTrack() -> RTCAudioTrack {
        let audioConstrains = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        let audioSource = WebRTCClient.factory.audioSource(with: audioConstrains)
        let audioTrack = WebRTCClient.factory.audioTrack(with: audioSource, trackId: "audio0")
        return audioTrack
    }
    
    private func createVideoTrack() -> RTCVideoTrack {
        let videoSource = WebRTCClient.factory.videoSource()
        
        //        #if TARGET_OS_SIMULATOR
        videoCapturer = RTCFileVideoCapturer(delegate: videoSource)
        //        #else
        //        self.videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)
        //        #endif
        
        let videoTrack = WebRTCClient.factory.videoTrack(with: videoSource, trackId: "video0")
        return videoTrack
    }
}

extension RTCMediaConstraints {
    convenience init(constraints mandatory: [String : String]? = nil, optional: [String : String]? = nil) {
        self.init(mandatoryConstraints: mandatory, optionalConstraints: optional)
    }
}

