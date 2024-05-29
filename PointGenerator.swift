//
//  Models.swift
//  Ramen Clicker
//
//  Created by Joshua Zhang on 5/21/24.
//

import Foundation

struct PointGenerator: Identifiable {
    var id = UUID() // Unique Identification Number for said generator
    var name:String // Allows for unique generator names
    var pointsPerSecond: Int // Points generated per second by the generator
    var price: Int // Cost it takes to upgrade said generator
    var level:Int // Level of said generator
}
