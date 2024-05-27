//
//  GameState.swift
//  Ramen Clicker
//
//  Created by Joshua Zhang on 5/21/24.
//

import Foundation

class GameState: ObservableObject {
    @Published var points = 0
    @Published var pointsPerSecond = 0
    @Published var pointGenerators:[PointGenerator] = [
        PointGenerator(name: "Point Generator #1", pointsPerSecond: 1, price:50, level: 0),
        PointGenerator(name: "Point Generator #2", pointsPerSecond: 2, price:100, level: 0),
        PointGenerator(name: "Point Generator #3", pointsPerSecond: 5, price:250, level: 0),
        PointGenerator(name: "Point Generator #4", pointsPerSecond: 10, price:500, level: 0),
        PointGenerator(name: "Point Generator #5", pointsPerSecond: 25, price:1000, level: 0)
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
            self.pointGenerators = newPointGenerators
        }
    }
    
    func tick() {
        self.points += self.pointsPerSecond
    }
}
