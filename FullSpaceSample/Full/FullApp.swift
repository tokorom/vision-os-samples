//
//  FullApp.swift
//  Full
//
//  Created by Yuta Tokoro on 2023/07/07.
//

import SwiftUI

@main
struct FullApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
