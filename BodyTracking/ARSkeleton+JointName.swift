//
//  ARSkeleton+JointName.swift
//  BodyTracking
//
//  Created by Justin Lee on 2/2/23.
//

import Foundation
import ARKit

func == (lhs: ARSkeleton.JointName, rhs: ARSkeleton.JointName) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func ~= (lhs: ARSkeleton.JointName, rhs: ARSkeleton.JointName) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public extension ARSkeleton.JointName {
    typealias Joint = ARSkeleton.JointName
    
    // MARK: - Static constants
    
    static let leftArm = Joint(rawValue: Name.leftArm)
    static let leftForearm = Joint(rawValue: Name.leftForearm)
    
    static let leftUpLeg = Joint(rawValue: Name.leftUpLeg)
    static let leftLeg = Joint(rawValue: Name.leftLeg)
    static let leftFoot = Joint(rawValue: Name.leftFoot)
    
    static let rightArm = Joint(rawValue: Name.rightArm)
    static let rightForearm = Joint(rawValue: Name.rightForearm)
    
    static let rightUpLeg = Joint(rawValue: Name.rightUpLeg)
    static let rightLeg = Joint(rawValue: Name.rightLeg)
    static let rightFoot = Joint(rawValue: Name.rightFoot)
    
    static let neck1 = Joint(rawValue: Name.neck1)
    static let spine7 = Joint(rawValue: Name.spine7)
    static let spine6 = Joint(rawValue: Name.spine6)
    static let spine5 = Joint(rawValue: Name.spine5)
    static let hips = Joint(rawValue: Name.hips)
    
    static let jaw = Joint(rawValue: Name.jaw)
    static let chin = Joint(rawValue: Name.chin)
    static let nose = Joint(rawValue: Name.nose)
    
    // MARK: - Instance Prefix Check Methods
    
    var isLeftFingersJoint: Bool { rawValue.has(Prefix.leftFingers) && rawValue != Joint.leftHand.rawValue }
    var isRightFingersJoint: Bool { rawValue.has(Prefix.rightFingers) && rawValue != Joint.rightHand.rawValue }
    
    var isLeftToesJoint: Bool { rawValue.has(Prefix.leftToes) }
    var isRightToesJoint: Bool { rawValue.has(Prefix.rightToes) }
    
    var isLeftEyeJoint: Bool { rawValue.has(Prefix.leftEye) }
    var isRightEyeJoint: Bool { rawValue.has(Prefix.rightEye) }
    
    var isSpineJoint: Bool { rawValue.has(Prefix.spine) }
    var isNeckJoint: Bool { rawValue.has(Prefix.neck) }
    
    // MARK: - ARKit String Constants
    
    private enum Name {
        static let leftArm = "left_arm_joint"
        static let leftForearm = "left_forearm_joint"

        static let leftUpLeg = "left_upLeg_joint"
        static let leftLeg = "left_leg_joint"
        static let leftFoot = "left_foot_joint"
        
        static let rightArm = "right_arm_joint"
        static let rightForearm = "right_forearm_joint"
        
        static let rightUpLeg = "right_upLeg_joint"
        static let rightLeg = "right_leg_joint"
        static let rightFoot = "right_foot_joint"
        
        static let neck1 = "neck_1_joint"
        static let spine7 = "spine_7_joint"
        static let spine6 = "spine_6_joint"
        static let spine5 = "spine_5_joint"
        static let hips = "hips_joint"
        
        static let jaw = "jaw_joint"
        static let chin = "chin_joint"
        static let nose = "nose_joint"
    }
    
    private enum Prefix {
        static let leftFingers = "left_hand"
        static let rightFingers = "right_hand"
        
        static let leftToes = "left_toes"
        static let rightToes = "right_toes"
        
        static let leftEye = "left_eye"
        static let rightEye = "right_eye"
        
        static let spine = "spine_"
        static let neck = "neck_"
    }
}

private extension String {
    func has(_ prefix: String) -> Bool {
        self.hasPrefix(prefix)
    }
}
