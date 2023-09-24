//
//  FullSpaceView.swift
//  FullSpaceSample
//
//  Created by Yuta Tokoro on 2023/06/28.
//

import RealityKit
import SwiftUI

struct FullSpaceView: View {
    var body: some View {
        RealityView { content in
            let model = Model3D(named: "maneki") { phase in
                if let model = phase.model {
                    model
                } else if let error = phase.error {
                    Text(error.localizedDescription)
                } else {
                    Text("other reasons...")
                }
            }
            content.add(model)
        }
    }
}

#Preview {
    FullSpaceView()
}
