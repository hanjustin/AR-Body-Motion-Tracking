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
        // nothing to do
    }
}

// MARK: - Coordinator

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
        
        func jointUICustomization(for joint: ARSkeleton.JointName) -> (radius: Float, color: UIColor) {
            var jointRadius = UIConstants.Radius.XLarge
            let jointColor = joint.isTrackedJoint ? UIConstants.Color.trackedJoint : UIConstants.Color.notTrackedJoint
            
            switch joint {
            case .leftShoulder, .rightShoulder, .head, \.isNeckJoint:
                jointRadius = UIConstants.Radius.medium
            case .jaw, .chin, .nose, \.isLeftEyeJoint, \.isRightEyeJoint, \.isLeftFingersJoint, \.isRightFingersJoint:
                jointRadius = UIConstants.Radius.small
            case \.isLeftToesJoint, \.isRightToesJoint:
                jointRadius = UIConstants.Radius.medium
            case \.isSpineJoint:
                jointRadius = UIConstants.Radius.large
            default:
                break
            }
            
            return (jointRadius, jointColor)
        }
        
        private func firstTimeInitialization(with bodyAnchor: ARBodyAnchor) {
            let newBodySkeleton = BodySkeletonEntity(for: bodyAnchor, with: jointUICustomization)
            bodySkeleton = newBodySkeleton
            bodySkeletonAnchor.addChild(newBodySkeleton)
        }
        
        private enum UIConstants {
            enum Color {
                static let notTrackedJoint = UIColor.yellow
                static let trackedJoint = UIColor.green
            }
            
            enum Radius {
                static let XLarge: Float = 0.05
                static let large = XLarge * 0.75
                static let medium = XLarge * 0.5
                static let small = XLarge * 0.25
            }
        }
    }
}
