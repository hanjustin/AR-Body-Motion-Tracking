//
//  ContentView.swift
//  BodyTracking
//
//  Created by Justin Lee on 1/26/23.
//

import SwiftUI
import ARKit

struct ContentView: View {
    var body: some View {
        if ARBodyTrackingConfiguration.isSupported {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
        } else {
            Text(ErrorMsg.BodyTrackingUnsupported)
        }
    }
    
    private enum ErrorMsg {
        static let BodyTrackingUnsupported = "AR body tracking is not supported on this device."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
