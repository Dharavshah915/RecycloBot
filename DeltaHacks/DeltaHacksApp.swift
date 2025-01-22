//
//  DeltaHacksApp.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import SwiftUI
import FirebaseCore

var globalUsername: String = "Lando"

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct DeltaHacksApp: App {
    // MARK: initialize firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            GarbageTabView()
        }
    }
}
