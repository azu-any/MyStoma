//
//  Functions.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//

import SwiftUI
import simd

let stomaTargetPosition = SIMD3<Float>(0.96, 1.025, -1.32)
let wasteBagTargetPosition = SIMD3<Float>(0.15, 0.88, -1.5)
let bottleTargetPosition = SIMD3<Float>(-0.25, 0.8, -1.5)

let cleanBagPosition = SIMD3<Float>(0.25, 0.85, -1.6)


let tablePosition = SIMD3<Float>(0, 0, -1.50)
let tableBoundingBoxMin = SIMD3<Float>(-0.47335356, -0.075258516, -1.6806084)
let tableBoundingBoxMax = SIMD3<Float>(0.41929293, 0.7959688, -1.319781)

let threshold: Float = 0.15


let skinColors: [String: Color] = [
    "DarkColor": Color(red: 60/255, green: 32/255, blue: 4/255),
    "DarkerColor": Color(red: 30/255, green: 15/255, blue: 0/255),
    "LightColor": Color(red: 153/255, green: 112/255, blue: 100/255),
    "LighterColor": Color(red: 240/255, green: 205/255, blue: 186/255),
]
