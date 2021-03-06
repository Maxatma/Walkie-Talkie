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
import SwiftyUserDefaults


final class JoinVM: BondViewModel {
    var webRTCClient: WebRTCClient!
    var signalingClient: SignalingClient!
    let isCreatingRoom = Observable<Bool>(true)
    let state = Observable<String>("")
    let create = SafePublishSubject<Void>()
    let join = SafePublishSubject<Void>()
    let roomID = Observable<String>("")
    let isButtonsEnabled = Observable<Bool>(false)
    
    init(webRTCClient: WebRTCClient) {
        super.init()
        self.webRTCClient = webRTCClient
        webRTCClient.delegate = self
        signalingClient = SignalingClient.shared
        
        roomID.map { $0 != nil && $0!.count > 0 }.bind(to: isButtonsEnabled).dispose(in: bag)
        
        create.map { true }.bind(to: isCreatingRoom).dispose(in: bag)
        join.map { false }.bind(to: isCreatingRoom).dispose(in: bag)
        
        create
            .observeNext { [weak self] in
                guard let me = self else { return }
                
                Defaults[\.roomIds].append(me.roomID.value)
                let callVM = CallVM(webRTCClient: webRTCClient)
                Router.shared.showCall(vm: callVM)
                
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
                                    let callVM = CallVM(webRTCClient: webRTCClient)
                                    Router.shared.showCall(vm: callVM)
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
        print("isCreating ", isCreatingRoom.value)
        let candidate = IceCandidate(from: candidate)
        
        signalingClient.collect(iceCandidate: candidate,
                                id: roomID.value,
                                name: isCreatingRoom.value ? "callerCandidates" : "calleeCandidates")
    }
    
    func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState) {
        self.state.send(state.description)
        print("WebRTCClientDelegate didChangeConnectionState ", state)
    }
    
    func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data) {
        print("didReceiveData ", data)
    }
}

