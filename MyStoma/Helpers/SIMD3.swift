//
//  SIMD3.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 09/05/25.
//


import SwiftUI

/// The extension of `SIMD3` where the scalar is a float.
extension SIMD3 where Scalar == Float {
    /// The variable to lock the y-axis value to 0.
    var grounded: SIMD3<Scalar> {
        return .init(x: x, y: 0, z: z)
    }
}
