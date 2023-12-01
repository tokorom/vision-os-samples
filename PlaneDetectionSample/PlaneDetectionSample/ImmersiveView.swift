//
//  ImmersiveView.swift
//  PlaneDetectionSample
//
//  Created by Yuta Tokoro on 2023/11/01.
//

import ARKit
import Observation
import RealityKit
import SwiftUI

struct ImmersiveView: View {
    @State var model = ViewModel()

    var body: some View {
        RealityView { content in
            content.add(model.contentEntity)
        }
        .task {
            do {
                try await model.run()
            } catch {
                print(error)
            }
        }
    }
}

extension ImmersiveView {
    final class ViewModel {
        lazy var contentEntity = Entity()

        private let session = ARKitSession()
        private let planeData = PlaneDetectionProvider(alignments: [.horizontal, .vertical])

        func run() async throws {
            try await session.run([planeData])

            for await update in planeData.anchorUpdates {
                let anchor = update.anchor

                switch update.event {
                case .added, .updated:
                    Task {
                        try await updateAnchor(anchor)
                    }
                case .removed:
                    Task {
                        try await removeAnchor(anchor)
                    }
                }
            }
        }

        @MainActor private func updateAnchor(_ anchor: PlaneAnchor) async throws {
            let name = "PlaneAnchor-\(anchor.id)"

            if let anchorEntity = contentEntity.findEntity(named: name) {
                if let modelEntity = anchorEntity.findEntity(named: "model") {
                    modelEntity.transform = Transform(matrix: anchor.geometry.extent.anchorFromExtentTransform)
                }
                anchorEntity.transform = Transform(matrix: anchor.originFromAnchorTransform)
            } else {
                // let anchorEntity = AnchorEntity(world: anchor.originFromAnchorTransform)
                // let anchorEntity = AnchorEntity(world: anchor.geometry.extent.anchorFromExtentTransform)

                let material = UnlitMaterial(color: anchor.classification.color)
                let modelEntity = ModelEntity(mesh: .generatePlane(width: anchor.geometry.extent.width, height: anchor.geometry.extent.height), materials: [material])
                modelEntity.name = "model"
                modelEntity.transform = Transform(matrix: anchor.geometry.extent.anchorFromExtentTransform)

                let textEntity = ModelEntity(mesh: .generateText(anchor.classification.description))
                textEntity.scale = SIMD3(0.01, 0.01, 0.01)
                modelEntity.addChild(textEntity)

                let anchorEntity = Entity()
                anchorEntity.transform = Transform(matrix: anchor.originFromAnchorTransform)
                anchorEntity.name = name
                anchorEntity.addChild(modelEntity)
                contentEntity.addChild(anchorEntity)
            }
        }

        @MainActor private func removeAnchor(_ anchor: PlaneAnchor) async throws {
            let name = "PlaneAnchor-\(anchor.id)"
            if let anchorEntity = contentEntity.findEntity(named: name) {
                anchorEntity.removeFromParent()
            }
        }
    }
}

// MARK: - PlaneAnchor.Classification

extension PlaneAnchor.Classification {
    fileprivate var color: UIColor {
        switch self {
        case .wall:
            return UIColor.blue.withAlphaComponent(0.65)
        case .floor:
            return UIColor.red.withAlphaComponent(0.65)
        case .ceiling:
            return UIColor.green.withAlphaComponent(0.65)
        case .table:
            return UIColor.yellow.withAlphaComponent(0.65)
        case .door:
            return UIColor.brown.withAlphaComponent(0.65)
        case .seat:
            return UIColor.systemPink.withAlphaComponent(0.65)
        case .window:
            return UIColor.orange.withAlphaComponent(0.65)
        case .undetermined:
            return UIColor.lightGray.withAlphaComponent(0.65)
        case .notAvailable:
            return UIColor.gray.withAlphaComponent(0.65)
        case .unknown:
            return UIColor.black.withAlphaComponent(0.65)
        @unknown default:
            return UIColor.purple
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
