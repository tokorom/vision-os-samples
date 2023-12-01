//
//  SimplestFullImmersionApp.swift
//  SimplestFullImmersion
//
//  Created by Yuta Tokoro on 2023/09/28.
//

import SwiftUI

@main
struct SimplestFullImmersionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
