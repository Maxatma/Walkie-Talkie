//
//  JoinVM.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/6/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import ReactiveKit
import Bond
import WebRTC


final class JoinVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    var signalingClient: SignalingClient!
    let isCreatingRoom = Observable<Bool>(true)
    let state = Observable<String>("")

    let create = SafePublishSubject<Void>()
    let join = SafePublishSubject<Void>()
    let roomID = Observable<String>("")

    init(webRTCClient: WebRTCClient) {
        super.init()
        self.webRTCClient = webRTCClient
        webRTCClient.delegate = self
        signalingClient = SignalingClient.shared

        create
            .observeNext { [weak self] in
                guard let me = self else { return }
                me.isCreatingRoom.next(true)
                print("create ")
                me.signalingClient.createRoom()
                me.webRTCClient.offer { rtcDescription in
                    print("me.webRTCClient.offer")
                    let descr = SessionDescription(from: rtcDescription)
                    me.signalingClient.createOfferAndSubscribe(desc: descr, id: me.roomID.value)
                        .observeNext { sessionDescrip in
                            print("createOfferAndSubscribe next ")
                            print("got answer sessionDescription ", sessionDescrip)
                            me.signalingClient
                                .getRemoteIceCandidates(id: me.roomID.value, name: "calleeCandidates")
                                .observeNext { candiates in
                                    let rtcCandiates = candiates.map {
                                        $0.rtcIceCandidate
                                    }
                                    rtcCandiates.forEach {
                                        me.webRTCClient.set(remoteCandidate: $0)
                                    }
                            }
                            .dispose(in: me.bag)
                            me.webRTCClient.set(remoteSdp: sessionDescrip.rtcSessionDescription) { error in
                                if let error = error {
                                    print("createOfferAndSubscribe error set(remoteSdp: ", error)
                                }
                            }
                    }
                    .dispose(in: me.bag)
                }
        }
        .dispose(in: bag)
        
        join
            .observeNext { [weak self] in
                guard let me = self else { return }
                print("join ")
                me.isCreatingRoom.next(false)

                me.signalingClient
                    .getRemoteIceCandidates(id: me.roomID.value, name: "callerCandidates")
                    .observeNext { candiates in
                        print("candidates: ", candiates)
                        let rtcCandiates = candiates.map {
                            $0.rtcIceCandidate
                        }
                        rtcCandiates.forEach {
                            me.webRTCClient.set(remoteCandidate: $0)
                        }
                        
                        me.signalingClient
                            .subscribeForRemoteOffer(roomId: me.roomID.value)
                            .observeNext { descr in
                                me.webRTCClient.set(remoteSdp: descr.rtcSessionDescription) { error in
                                    if let error = error  {
                                        print("webRTCClient set description error ", error)
                                    } else {
                                        print("webRTCClient set description done! ")
                                    }
                                }

                                me.webRTCClient.answer { descr in
                                    print("descr is ", descr)
                                    me.signalingClient.createAnswer(desc: SessionDescription(from: descr), id: me.roomID.value)
                                }
                        }
                        .dispose(in: me.bag)
                }
                .dispose(in: me.bag)
        }
        .dispose(in: bag)
    }
}


extension JoinVM: WebRTCClientDelegate {
    
    func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate) {
        print("WebRTCClientDelegate didDiscoverLocalCandidate ")
        
        let candidate = IceCandidate(from: candidate)
        
        signalingClient.collect(iceCandidate: candidate,
                                id: roomID.value,
                                name: isCreatingRoom.value ? "callerCandidates" : "calleeCandidates")
    }
    
    func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState) {
        self.state.next(state.description)
        print("WebRTCClientDelegate didChangeConnectionState ", state)
    }
    
    func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data) {
        print("didReceiveData ", data)
    }
}

