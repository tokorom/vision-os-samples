//
//  _DModelOnSwiftUISampleApp.swift
//  3DModelOnSwiftUISample
//
//  Created by Yuta Tokoro on 2023/06/26.
//

import SwiftUI

@main
struct app: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 600, height: 600, depth: 600)
    }
}
