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

        private var entities: [UUID: Entity] = [:]

        private let session = ARKitSession()
        private let planeData = PlaneDetectionProvider(alignments: [.horizontal, .vertical])

        func run() async throws {
            try await session.run([planeData])

            for await update in planeData.anchorUpdates {
                let anchor = update.anchor

                switch update.event {
                case .added, .updated:
                    Task {
                        await updateAnchor(anchor)
                    }
                case .removed:
                    Task {
                        await removeAnchor(anchor)
                    }
                }
            }
        }

        @MainActor private func updateAnchor(_ anchor: PlaneAnchor) {
            if entities[anchor.id] == nil {
                let material = UnlitMaterial(color: anchor.classification.color)
                let entity = ModelEntity(mesh: .generatePlane(width: anchor.geometry.extent.width, depth: anchor.geometry.extent.height), materials: [material])
                entities[anchor.id] = entity
                contentEntity.addChild(entity)
            }
            entities[anchor.id]?.transform = Transform(matrix: anchor.originFromAnchorTransform)
        }

        @MainActor private func removeAnchor(_ anchor: PlaneAnchor) {
            entities[anchor.id]?.removeFromParent()
            entities.removeValue(forKey: anchor.id)
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
