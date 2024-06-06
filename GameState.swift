//
//  GameState.swift
//  Ramen Clicker
//
//  Created by Joshua Zhang on 5/21/24.
//

import Foundation

class GameState: ObservableObject {
    // Establish Generators and set values
    @Published var points = 0
    @Published var pointsPerSecond = 0
    @Published var pointGenerators:[PointGenerator] = [
        PointGenerator(name: "Employee", pointsPerSecond: 1, price: 50, level: 0, imageName: "Ramen Worker"),
        PointGenerator(name: "Workstation", pointsPerSecond: 2, price: 2000, level: 0, imageName: "Workstation"),
        PointGenerator(name: "Panda Guard", pointsPerSecond: 5, price: 10000, level: 0, imageName: "Panda Guard"),
        PointGenerator(name: "Golden Egg", pointsPerSecond: 10, price: 50000, level: 0, imageName: "Golden Egg"),
        PointGenerator(name: "Lucky Cat", pointsPerSecond: 25, price: 100000, level: 0, imageName:"Lucky Cat")
    ]
    
    var time: Timer?
    
    init(){
        self.points = 1
        self.time = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true , block: {_ in self.tick()
        })
    }
    
    func click() {
        self.points += 1
    }
    
    func purchase(pointGenerator:PointGenerator) {
        if pointGenerator.price <= self.points {
            self.points -= pointGenerator.price
            self.pointsPerSecond += pointGenerator.pointsPerSecond
            
            var newPointGenerators = self.pointGenerators
            let index = newPointGenerators.firstIndex(where: {$0.id == pointGenerator.id})!
            newPointGenerators[index].level += 1
            newPointGenerators[index].price *= (index + 2) // Allows Game to scale accordingly
            self.pointGenerators = newPointGenerators
        }
    }
    
    func tick() {
        self.points += self.pointsPerSecond
    }
}
