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
            let entity = Entity()
            content.add(entity)
            let box = ModelEntity(mesh: .generateBox(size: 0.5))
            box.position = .init(x: 0.5, y: 1.5, z: -1)
            entity.addChild(box)
        }
    }
}

#Preview {
    FullSpaceView()
}
