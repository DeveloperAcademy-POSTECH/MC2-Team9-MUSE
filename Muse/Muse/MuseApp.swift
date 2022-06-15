//
//  MuseApp.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI
import Firebase

/**
 * App Delegate
 */

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct MuseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    ContentView()
                        .environmentObject(sessionService)
                case .loggedOut:
                    LoginView()
                }
            }
        }
    }
}
