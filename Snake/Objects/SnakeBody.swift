//
//  File.swift
//  Snake
//
//  Created by Kim Ilya on 10/05/2020.
//  Copyright © 2020 rstarfir. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    let diameter = 15.0
    
    init (atPoint point: CGPoint){
      super.init()
      
      path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
      
      fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
      strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
      lineWidth = 5
      
      self.position = point
      
      self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diameter - 4), center: CGPoint(x: 5, y:5))
      
      self.physicsBody?.isDynamic = true
      
      self.physicsBody?.categoryBitMask = CollisionCategories.Snake
      
      self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
