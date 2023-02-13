//
//  BoneEntity.swift
//  BodyTracking
//
//  Created by Justin Lee on 2/1/23.
//

import SwiftUI
import RealityKit

class JointEntity: Entity, HasModel, HasPhysics {
    required init(name: String, radius: Float, color: UIColor = .white) {
        super.init()
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: color, roughness: 0.8, isMetallic: false)
        
        self.name = name
        self.model = ModelComponent(mesh: mesh, materials: [material])
      }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    private enum Constants {
        static let defaultRoughness = MaterialScalarParameter.init(floatLiteral: 0.8)
    }
}
