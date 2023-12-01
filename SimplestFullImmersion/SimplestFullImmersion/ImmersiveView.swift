//
//  ImmersiveView.swift
//  SimplestFullImmersion
//
//  Created by Yuta Tokoro on 2023/09/28.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            let entity = Entity()
            content.add(entity)
            let box = ModelEntity(mesh: .generateBox(size: 0.5))
            box.position = .init(x: 0.5, y: 1.5, z: -0.5)
            entity.addChild(box)
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
