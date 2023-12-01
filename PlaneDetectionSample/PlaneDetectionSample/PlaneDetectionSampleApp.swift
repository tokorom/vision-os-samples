//
//  PlaneDetectionSampleApp.swift
//  PlaneDetectionSample
//
//  Created by Yuta Tokoro on 2023/11/01.
//

import SwiftUI

@main
struct PlaneDetectionSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
