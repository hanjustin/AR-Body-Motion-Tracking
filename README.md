![Swift Version](https://img.shields.io/badge/Swift-5.4+-Green) ![Xcode](https://img.shields.io/badge/Xcode-14.2-blue) ![Platform iOS](https://img.shields.io/badge/platform-iOS-lightgrey) ![Contact](https://img.shields.io/badge/contact-justin.lee.iosdev%40gmail.com-yellowgreen)

# Demo video - [Download1](/Demo/BodyMotion.gif), [Download2](/Demo/Treadmill.gif)
<p align="center">
  <img alt="Light" src="./Demo/BodyMotion.gif" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
  <img alt="Dark" src="./Demo/Treadmill.gif" width="45%">
</p>

# Description
Track a person in the physical environment and visualize their motion by applying the same body movements to a skeleton overlay using ARKit’s Motion Capture technology, RealityKit and SwiftUI.

# Requirements
* Swift 5.4+
* Xcode 14.2+

# Folder Structure
    ├── BodyTracking App 
        ├── View
            ├── ContentView
            ├── ARViewContainer
        ├── Entity
            ├── BoneEntity
            ├── JointEntity
            ├── BodySkeletonEntity
        ├── ARSkeleton+Extensions
            ├── ARSkeleton+Bone
            ├── ARSkeleton+JointName
