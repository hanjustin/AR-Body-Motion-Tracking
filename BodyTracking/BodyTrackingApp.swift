//
//  BodyTrackingApp.swift
//  BodyTracking
//
//  Created by Justin Lee on 1/26/23.
//

import SwiftUI

@main
struct BodyTrackingApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                UIApplication.shared.isIdleTimerDisabled = true
            }
        }
    }
}
