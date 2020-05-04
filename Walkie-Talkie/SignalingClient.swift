//
//  SignalClient.swift
//  WebRTC
//
//  Created by Zaporozhchenko Oleksandr on 4/25/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import WebRTC
import Firebase
import FirebaseFirestore
import ReactiveKit
import Bond


final class SignalingClient {
    static let shared = SignalingClient()
    
    //MARK: - CREATE
    
    func createOfferAndSubscribe(desc: SessionDescription?, id: String) -> SafeSignal<SessionDescription> {
        return createOffer(desc: desc, id: id)
            .flatMapLatest { [unowned self] _ in
                return self.subscribeForAnswer(id: id)
        }
    }
    
    
    func createRoom() {
        Firestore.firestore()
            .collection("rooms")
            .addDocument(data: [:])
    }
    
    private func subscribeForAnswer(id: String) -> SafeSignal<SessionDescription> {
        return Signal { observer in
            
            Firestore.firestore()
                .collection("rooms")
                .document(id)
                .addSnapshotListener { snapshot, error in
                    
                    if let error = error {
                        print("error is ", error)
                        // observer.failed(error as! NSError)
                        return
                    }
                    
                    guard let snapshot = snapshot, snapshot.exists else {
                        print("no snapshot ")
                        return
                    }
                    
                    guard let answer = snapshot.get("answer") as? [String: String] else {
                        print("no answer ")
                        return
                    }
                    
                    guard let sdp = answer["sdp"] else {
                        print("no sdp in answer" )
                        return
                    }
                    
                    let description = SessionDescription(from: RTCSessionDescription(type: .answer, sdp: sdp))
                    observer.next(description)
                    observer.completed()
            }
            
            return BlockDisposable { }
        }
    }
    
    private func createOffer(desc: SessionDescription?, id: String) -> SafeSignal<Void> {
        return Signal { observer in
            let offer = desc.asDictionary()
            
            Firestore.firestore()
                .collection("rooms")
                .document(id)
                .setData(["offer": offer],
                         completion: { error in
                            if let error = error {
                                print("error is ", error)
                                //observer.failed(error as! NSError)
                                return
                            }
                            observer.next()
                            observer.completed()
                            
                })
            
            return BlockDisposable { }
        }
    }
    
    //MARK: - JOIN
    
    func createAnswer(desc: SessionDescription?, id: String) {
        let answer = desc.asDictionary()
        
        Firestore.firestore()
            .collection("rooms")
            .document(id)
            .setData(["answer": answer])
    }
    
    func subscribeForRemoteOffer(roomId: String) ->SafeSignal<SessionDescription> {
        return Signal { observer in
            
            Firestore.firestore()
                .collection("rooms")
                .document(roomId)
                .addSnapshotListener { snapshot, error in
                    
                    if let error = error {
                        print("error is ", error)
                        // observer.failed(error as! NSError)
                        return
                    }
                    
                    guard let snapshot = snapshot, snapshot.exists else {
                        print("no snapshot ")
                        return
                    }
                    
                    guard let remoteOffer = snapshot.data()?["offer"] as? [String: Any] else {
                        print("no offer ")
                        return
                    }
                    
                    guard let sdp = remoteOffer["sdp"] as? String else {
                        print("no sdp in offer" )
                        return
                    }
                    
                    let description = SessionDescription(from: RTCSessionDescription(type: .offer, sdp: sdp))
                    observer.next(description)
                    observer.completed()
            }
            
            return BlockDisposable { }
        }
    }
    
    //MARK: - Candidates
    
    func collect(iceCandidate: IceCandidate?, id: String, name: String) {
        
        guard let iceCandidate = iceCandidate else {
            return
        }
        
        let ice = [
            "candidate": iceCandidate.sdp,
            "sdpMLineIndex": iceCandidate.sdpMLineIndex,
            "sdpMid": iceCandidate.sdpMid ?? "0"
            ] as [String : Any]
        
        Firestore.firestore()
            .collection("rooms")
            .document(id)
            .collection(name)
            .addDocument(data: ice)
    }
    
    func getRemoteIceCandidates(id: String, name: String) -> SafeSignal<[IceCandidate]> {
        return Signal { observer in
            Firestore.firestore()
                .collection("rooms")
                .document(id)
                .collection(name)
                .addSnapshotListener { snapshot, error in
                    
                    if let error = error {
                        print("error ", error)
                        return
                    }
                    
                    let dataChanges = snapshot!.documentChanges.filter { $0.type == .added }
                    
                    let ices = dataChanges
                        .map { change -> IceCandidate in
                            let data = change.document.data()
                            
                            return IceCandidate(from:
                                RTCIceCandidate(sdp: data["candidate"] as! String,
                                                sdpMLineIndex: data["sdpMLineIndex"] as! Int32,
                                                sdpMid: data["sdpMid"] as? String))
                    }
                    
                    observer.next(ices)
                    observer.completed()
            }
            
            return BlockDisposable { }
        }
    }
    
}

extension Encodable {
    func asDictionary() -> [String: Any] {
        let data = try! JSONEncoder().encode(self)
        guard let dictionary = try! JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            return [String: Any]()
        }
        return dictionary
    }
}

