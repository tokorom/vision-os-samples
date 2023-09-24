//
//  FullSpaceSampleApp.swift
//  FullSpaceSample
//
//  Created by Yuta Tokoro on 2023/06/28.
//

import SwiftUI

@main
struct FullSpaceSampleApp: App {
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
