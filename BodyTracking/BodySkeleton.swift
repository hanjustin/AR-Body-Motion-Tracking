//
//  BodySkeleton.swift
//  BodyTracking
//
//  Created by Justin Lee on 1/26/23.
//

import Foundation
import ARKit
import RealityKit

class BodySkeleton: Entity {
    var joints: [String: Entity] = [:]
    var bones: [String: Entity] = [:]
    
    // MARK: - Init
    
    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(with bodyAnchor: ARBodyAnchor) {
        
    }
    
}
