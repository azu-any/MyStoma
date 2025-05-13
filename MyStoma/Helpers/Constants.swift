//
//  Functions.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//

import Foundation
import simd

let stomaTargetPosition = SIMD3<Float>(0.96, 1.025, -1.32)
let wasteBagTargetPosition = SIMD3<Float>(0, 0.8, -1.5)
let bottleTargetPosition = SIMD3<Float>(-0.3, 0.8, -1.5)
let cleanBagPosition = SIMD3<Float>(0.25, 0.9, -1.5)


let tablePosition = SIMD3<Float>(0, 0, -1.50)
let tableBoundingBoxMin = SIMD3<Float>(-0.47335356, -0.075258516, -1.6806084)
let tableBoundingBoxMax = SIMD3<Float>(0.41929293, 0.7959688, -1.319781)

let threshold: Float = 0.15
