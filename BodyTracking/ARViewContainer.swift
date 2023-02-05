//
//  ARViewContainer.swift
//  BodyTracking
//
//  Created by Justin Lee on 1/26/23.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView
    
    private let bodySkeletonAnchor = AnchorEntity()
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        arView.session.run(ARBodyTrackingConfiguration())
        arView.session.delegate = context.coordinator
        arView.scene.addAnchor(bodySkeletonAnchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

// MARK: - ARSessionDelegate

extension ARViewContainer {
    func makeCoordinator() -> Coordinator {
        Coordinator(bodySkeletonAnchor: bodySkeletonAnchor)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        private var bodySkeleton: BodySkeletonEntity?
        private let bodySkeletonAnchor: AnchorEntity
        
        init(bodySkeletonAnchor: AnchorEntity) {
            self.bodySkeletonAnchor = bodySkeletonAnchor
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
                
                let didDetectBodyForTheFirstTime = bodySkeleton == nil
                if didDetectBodyForTheFirstTime {
                    firstTimeInitialization(with: bodyAnchor)
                } else {
                    bodySkeleton?.update(with: bodyAnchor)
                }
            }
        }
        
        private func firstTimeInitialization(with bodyAnchor: ARBodyAnchor) {
            let newBodySkeleton = BodySkeletonEntity(for: bodyAnchor)
            bodySkeleton = newBodySkeleton
            bodySkeletonAnchor.addChild(newBodySkeleton)
        }
    }
}
