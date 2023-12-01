//
//  MeshDetectorApp.swift
//  MeshDetector
//
//  Created by Yuta Tokoro on 2023/12/01.
//

import SwiftUI

@main
struct MeshDetectorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
