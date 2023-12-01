//
//  ImmersiveView.swift
//  AttachmentSample
//
//  Created by Yuta Tokoro on 2023/09/27.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    var body: some View {
        RealityView { content, attachments in
            let entity = Entity()
            content.add(entity)
            let box = ModelEntity(mesh: .generateBox(size: 0.1))
            box.position = .init(x: 0.5, y: 1.5, z: -1)
            entity.addChild(box)
            
            
            if let text = attachments.entity(for: "text") {
                text.position = [0, 0, 0]
                box.addChild(text)
            }
        } attachments: {
            Attachment(id: "text") {
                Color.red.frame(width: 100, height: 100)
            }
        }
    }
}
