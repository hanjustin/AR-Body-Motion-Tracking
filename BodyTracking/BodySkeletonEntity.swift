//
//  BodySkeletonEntity.swift
//  BodyTracking
//
//  Created by Justin Lee on 1/26/23.
//

import Foundation
import ARKit
import RealityKit

class BodySkeletonEntity: Entity {
    var joints = Set<JointEntity>()
    var bones = Set<BoneEntity>()
    // MARK: - Init
    
    required init(
        for bodyAnchor: ARBodyAnchor,
        with jointUICustomization: (ARSkeleton.JointName) -> (radius: Float, color: UIColor))
    {
        super.init()
        
        initializeJoints(with: jointUICustomization)
        initializeBones(for: bodyAnchor)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(with bodyAnchor: ARBodyAnchor) {
        updateJoints(with: bodyAnchor)
        updateBones(with: bodyAnchor)
    }
    
    // MARK: - Private Methods
    
    private func initializeJoints(with jointUICustomization: (ARSkeleton.JointName) -> (radius: Float, color: UIColor)) {
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
            let joint = ARSkeleton.JointName(rawValue: jointName)
            let (jointRadius, jointColor) = jointUICustomization(joint)
            let jointEntity = JointEntity(name: jointName, radius: jointRadius, color: jointColor)
            joints.insert(jointEntity)
            addChild(jointEntity)
        }
    }
    
    private func initializeBones(for bodyAnchor: ARBodyAnchor) {
        for bone in ARSkeleton.Bone.allBones {
            guard
                let jointFromPosition = bodyAnchor.getPositionInWorldCoordinates(for: bone.jointFrom),
                let jointToPosition = bodyAnchor.getPositionInWorldCoordinates(for: bone.jointTo)
            else { continue }
            
            let length = simd_distance(jointFromPosition, jointToPosition)
            let boneEntity = BoneEntity(bone: bone, length: length)
            bones.insert(boneEntity)
            addChild(boneEntity)
        }
    }
    
    private func updateJoints(with bodyAnchor: ARBodyAnchor) {
        for joint in joints {
            if
                let jointTransform = bodyAnchor.skeleton.modelTransform(for: joint.name),
                let worldPosition = bodyAnchor.getPositionInWorldCoordinates(for: joint.name)
            {
                joint.position = worldPosition
                joint.orientation = Transform(matrix: jointTransform).rotation
            }
        }
    }
    
    private func updateBones(with bodyAnchor: ARBodyAnchor) {
        for bone in bones {
            guard
                let jointFromPosition = bodyAnchor.getPositionInWorldCoordinates(for: bone.jointFrom),
                let jointToPosition = bodyAnchor.getPositionInWorldCoordinates(for: bone.jointTo)
            else { continue }
            
            let boneCenter = (jointFromPosition + jointToPosition) / 2
            bone.position = boneCenter
            bone.look(at: jointToPosition, from: boneCenter, relativeTo: nil) // set orientation for bone
        }
    }
}

private extension ARBodyAnchor {
    func getPositionInWorldCoordinates(for jointName: String) -> simd_float3? {
        getPositionInWorldCoordinates(for: .init(rawValue: jointName))
    }
    
    func getPositionInWorldCoordinates(for jointName: ARSkeleton.JointName) -> simd_float3? {
        guard let joint = skeleton.modelTransform(for: jointName) else { return nil }
        let rootPositionXYZ = simd_make_float3(transform.columns.3) // hip joint
        let offsetRelativeToRoot = simd_make_float3(joint.columns.3)
        let positionRelativeToWorldReferenceFrame = offsetRelativeToRoot + rootPositionXYZ
        return positionRelativeToWorldReferenceFrame
    }
}

private extension ARSkeleton3D {
    func modelTransform(for jointName: String) -> simd_float4x4? {
        modelTransform(for: .init(rawValue: jointName))
    }
}
