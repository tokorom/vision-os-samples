//
//  ContentView.swift
//  FullSpaceSample
//
//  Created by Yuta Tokoro on 2023/06/28.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    var body: some View {
        VStack {
            Button {
                Task {
                    await openImmersiveSpace(id: "full")
                }
            } label: {
                Text("Open Full Space")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
