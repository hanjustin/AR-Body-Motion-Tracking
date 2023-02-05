//
//  BoneEntity.swift
//  BodyTracking
//
//  Created by Justin Lee on 2/1/23.
//

import SwiftUI
import RealityKit
import ARKit

class BoneEntity: Entity, HasModel, HasPhysics {
    var bone: ARSkeleton.Bone
    
    required init(bone: ARSkeleton.Bone, length: Float, diameter: Float = Constants.defaultDiameter, color: UIColor = .white) {
        self.bone = bone
        
        super.init()
        let mesh = MeshResource.generateBox(size: [diameter, diameter, length], cornerRadius: diameter/2)
        let material = SimpleMaterial(color: color, roughness: Constants.defaultRoughness, isMetallic: true)
        self.model = ModelComponent(mesh: mesh, materials: [material])
      }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    private enum Constants {
        static let defaultDiameter: Float = 0.04
        static let defaultRoughness = MaterialScalarParameter.init(floatLiteral: 0.5)
    }
}
