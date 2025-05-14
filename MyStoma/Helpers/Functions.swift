//
//  Functions.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//

import Foundation
import simd
import RealityKit


func isObjectNearTableSurface(itemPosition: SIMD3<Float>) -> Bool {

    let isNearX = itemPosition.x <= tableBoundingBoxMax.x + 0.15
    let isNearZ = itemPosition.z <= tableBoundingBoxMax.z + 0.15
    let isAboveTable = itemPosition.y <= tableBoundingBoxMax.y + 0.15

    return isNearX && isNearZ && isAboveTable
}


/*func rotateEntity(_ entity: Entity, xDegrees: Float, yDegrees: Float) {
    let xRadians = xDegrees * (.pi / 180)
    let yRadians = yDegrees * (.pi / 180)

    let xRotation = simd_quatf(angle: xRadians, axis: [1, 0, 0])
    let yRotation = simd_quatf(angle: yRadians, axis: [0, 1, 0])

    // Combine the rotations (Y then X — order matters!)
    let combinedRotation = yRotation * xRotation

    entity.transform.rotation = combinedRotation
}*/


func rotateEntity(_ entity: Entity, xDegrees: Float, yDegrees: Float, zDegrees: Float = 0) {
    let xRadians = xDegrees * (.pi / 180)
    let yRadians = yDegrees * (.pi / 180)
    let zRadians = zDegrees * (.pi / 180)

    let xRotation = simd_quatf(angle: xRadians, axis: [1, 0, 0])
    let yRotation = simd_quatf(angle: yRadians, axis: [0, 1, 0])
    let zRotation = simd_quatf(angle: zRadians, axis: [0, 0, 1])

    // Combine the rotations (Z * Y * X — order matters!)
    let combinedRotation = zRotation * yRotation * xRotation

    entity.transform.rotation = combinedRotation
}



func canGoBack(index: Int) -> Bool {
    return index > 0
}


func canGoForward(index: Int, count: Int) -> Bool {
    return index < count - 1
}


func increaseIndex(currentIndex: Int, count: Int) -> Int {
    var index = currentIndex
    if currentIndex < count - 1 {
        index += 1
    }
    return index
}


func decreaseIndex(currentIndex: Int) -> Int {
    var index = currentIndex
    if currentIndex > 0 {
        index -= 1
    }
    return index
}
