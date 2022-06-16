//
//  FirebaseManager.swift
//  Muse
//
//  Created by kelly on 2022/06/16.
//
 
import Firebase
import SwiftUI

class FirebaseManager: NSObject {
    static let shared = FirebaseManager()
    //singleton : 디자인 패턴 -> 전체 폴더에서 딱 하나만 쓰겠다!!
    //정보 상자같은놈
    let firestore: Firestore
    private override init() {
        //FirebaseApp.configure() //공식문서니까 닥치고 써
        self.firestore = Firestore.firestore()
        super.init()
    }
}
