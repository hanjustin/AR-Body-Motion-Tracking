//
//  SkeletonBone.swift
//  BodyTracking
//
//  Created by Justin Lee on 1/26/23.
//

import Foundation
import RealityKit

struct SkeletonBone {
    var fromJoint: SkeletonJoint
    var toJoint: SkeletonJoint
    
    var centerPosition: SIMD3<Float> {
        let midX = (fromJoint.position.x + toJoint.position.x) / 2
        let midY = (fromJoint.position.y + toJoint.position.y) / 2
        let midZ = (fromJoint.position.z + toJoint.position.z) / 2
        return [midX, midY, midZ]
    }
    
    var length: Float {
        simd_distance(fromJoint.position, toJoint.position)
    }
}
