//
//  ARSkeleton+Bone.swift
//  BodyTracking
//
//  Created by Justin Lee on 2/3/23.
//

import Foundation
import ARKit

public extension ARSkeleton {
    struct Bone {
        private var from: ARSkeleton.JointName
        private var to: ARSkeleton.JointName
        
        var jointFrom: ARSkeleton.JointName { from }
        var jointTo: ARSkeleton.JointName { to }
        var name: String { from.rawValue + "-" + to.rawValue }
        
        static let allBones: [Bone] = {
           [leftArmBones, rightArmBones, spineBones, leftLegBones, rightLegBones].flatMap { $0 }
        }()
        private static let leftArmBones = [leftShoulderToLeftArm, leftArmToLeftForearm, leftForearmToLeftHand]
        private static let rightArmBones = [rightShoulderToRightArm, rightArmToRightForearm, rightForearmToRightHand]
        private static let spineBones = [spine7ToLeftShoulder, spine7ToRightShoulder, neck1ToSpine7, spine7ToSpine6, spine6ToSpine5]
        private static let leftLegBones = [hipsToLeftUpLeg, leftUpLegToLeftLeg, leftLegToLeftFoot]
        private static let rightLegBones = [hipsToRightUpLeg, rightUpLegToRightLeg, rightLegToRightFoot]
        
        static let leftShoulderToLeftArm = Bone(from: .leftShoulder, to: .leftArm)
        static let leftArmToLeftForearm = Bone(from: .leftArm, to: .leftForearm)
        static let leftForearmToLeftHand = Bone(from: .leftForearm, to: .leftHand)
        
        static let rightShoulderToRightArm = Bone(from: .rightShoulder, to: .rightArm)
        static let rightArmToRightForearm = Bone(from: .rightArm, to: .rightForearm)
        static let rightForearmToRightHand = Bone(from: .rightForearm, to: .rightHand)
        
        static let spine7ToLeftShoulder = Bone(from: .spine7, to: .leftShoulder)
        static let spine7ToRightShoulder = Bone(from: .spine7, to: .rightShoulder)
        
        static let neck1ToSpine7 = Bone(from: .neck1, to: .spine7)
        static let spine7ToSpine6 = Bone(from: .spine7, to: .spine6)
        static let spine6ToSpine5 = Bone(from: .spine6, to: .spine5)
        
        static let hipsToLeftUpLeg = Bone(from: .hips, to: .leftUpLeg)
        static let leftUpLegToLeftLeg = Bone(from: .leftUpLeg, to: .leftLeg)
        static let leftLegToLeftFoot = Bone(from: .leftLeg, to: .leftFoot)
        
        static let hipsToRightUpLeg = Bone(from: .hips, to: .rightUpLeg)
        static let rightUpLegToRightLeg = Bone(from: .rightUpLeg, to: .rightLeg)
        static let rightLegToRightFoot = Bone(from: .rightLeg, to: .rightFoot)
    }
}
