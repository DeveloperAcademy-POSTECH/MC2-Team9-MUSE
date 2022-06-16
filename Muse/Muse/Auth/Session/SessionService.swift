//
//  SessionService.swift
//  Muse
//
//  Created by kelly on 2022/06/14.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase
import Combine

// Create a protocol with the following
/**
 * Init
 * state
 * Publisher to return the user so in the view model you can map and create a struct
 */

// 현재 상태 정보 저장, 로그인 여부, 로그인 된 사용자 정보

enum SessionState {
    case loggedIn
    case loggedOut
}

class UserSessionDetails: Identifiable, ObservableObject {
    @Published var nickName: String = ""
    @Published var saveTrack: [String] = []
    
    init() {}
    
    init(data: [String: Any]) {
        self.nickName = data["nickName"] as? String ?? ""
        self.saveTrack = data["saveTrack"] as? [String] ?? ["a"]
    }
}

protocol SessionService {
    var state: SessionState { get }
    var userDetails: UserSessionDetails? { get }
    init()
    func logout()
}

final class SessionServiceImpl: SessionService, ObservableObject { // 로그인 여부에 따라 보여질 화면 핸들, 로그인된 유저 정보
    
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: UserSessionDetails?
    
    private var handler: AuthStateDidChangeListenerHandle? // firebasae에서 제공하는 핸들러, 로그인 상태를 알려줌
    
    init() {
        setupObservations()
    }
    
    deinit {
        guard let handler = handler else { return }
        Auth.auth().removeStateDidChangeListener(handler)
        print("deinit SessionServiceImpl")
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceImpl {
    
    func setupObservations() {
        
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] _,_ in
                guard let self = self else { return }
                
                let currentUser = Auth.auth().currentUser // 현재 유저 불러오기
                self.state = currentUser == nil ? .loggedOut : .loggedIn // 유저 있 -> 로그인, 우져 없 -> 로그아웃 (현재 상태 업데이트)
                
                if let uid = currentUser?.uid { // 현재 유저 있으면 아이디 받기
                    
                    FirebaseManager.shared.firestore
                        .collection("users") //식별자인 title을 불러 온다.
                        .document(uid)
                        .addSnapshotListener { snapshot, error in // Fire base just let me do this!
                            guard let snapshot = snapshot else { return }
                            print("cccccccc")
                            print(snapshot.data())
                            self.userDetails = UserSessionDetails(data: snapshot.data()!)
                            print("dddddddd")
                            print(self.userDetails?.nickName)
                            print(self.userDetails?.saveTrack)
                        }
                }
            }
    }
}
