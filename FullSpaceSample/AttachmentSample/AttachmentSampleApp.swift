//
//  AttachmentSampleApp.swift
//  AttachmentSample
//
//  Created by Yuta Tokoro on 2023/09/27.
//

import SwiftUI

@main
struct AttachmentSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
