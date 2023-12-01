//
//  ContentView.swift
//  SimplestFullImmersion
//
//  Created by Yuta Tokoro on 2023/09/28.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace

    var body: some View {
        Button("Open Immersive Space") {
            Task {
                await openImmersiveSpace(id: "ImmersiveSpace")
            }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
