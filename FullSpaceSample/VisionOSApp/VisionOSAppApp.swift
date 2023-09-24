//
//  VisionOSAppApp.swift
//  VisionOSApp
//
//  Created by Yuta Tokoro on 2023/07/07.
//

import SwiftUI

@main
struct VisionOSAppApp: App {
    @State private var immersionStyle: ImmersionStyle = .full
    
    var body: some Scene {
        WindowGroup("hello", id: "main") {
            ContentView()
        }
        .windowStyle(.plain)
        
        ImmersiveSpace(id: "full") {
            FullSpaceView()
        }
        .immersionStyle(selection: $immersionStyle, in: .full)
    }
}
