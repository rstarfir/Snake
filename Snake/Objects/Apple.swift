//
//  Apple.swift
//  Snake
//
//  Created by Kim Ilya on 10/05/2020.
//  Copyright © 2020 rstarfir. All rights reserved.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    convenience init(position: CGPoint) {
      self.init()
      path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 19, height: 19)).cgPath
      
      fillColor = #colorLiteral(red: 1, green: 0.0244654937, blue: 0.1179503128, alpha: 1)
      
      lineWidth = 0
      
      self.position = position
      
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x:5, y:5))
      
      self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}
