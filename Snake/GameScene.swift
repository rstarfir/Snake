//
//  GameScene.swift
//  Snake
//
//  Created by Kim Ilya on 10/05/2020.
//  Copyright © 2020 rstarfir. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories{
  static let Snake: UInt32 = 0x1 << 0
  static let SnakeHead: UInt32 = 0x1 << 1
  static let Apple: UInt32 = 0x1 << 2
  static let EdgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene{
    
    var snake: Snake?
    var score = 0
    let ScoreLbl = SKLabelNode()
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0.1517039835, green: 0.1517908871, blue: 0.1618559361, alpha: 1)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
         
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        counterClockwiseButton.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        counterClockwiseButton.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        self.addChild(counterClockwiseButton)
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX-80, y: view.scene!.frame.minY+30)
        clockwiseButton.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        clockwiseButton.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        self.addChild(clockwiseButton)
        
        
        ScoreLbl.fontName = "Arial Black"
        ScoreLbl.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7303349743)
        ScoreLbl.fontSize = 165.0
        ScoreLbl.text = "0"
        ScoreLbl.position = CGPoint(x: view.scene!.frame.width*0.5, y: view.scene!.frame.height*0.5 - 50)
        ScoreLbl.name = "ScoreLabel"
        self.addChild(ScoreLbl)
       
        createApple()
        createSnake()
        scoreIs()
       
        
        }
    
    func scoreIs(){
        score = 0
        ScoreLbl.text = "\(score)"
    }
    
    func createSnake() {
      
      snake?.removeFromParent()
      snake = Snake(atPoint: CGPoint(x: (view?.scene!.frame.midX)!, y: (view?.scene!.frame.midY)!))
      self.addChild(snake!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      for touch in touches {
        
        let touchLocation = touch.location(in: self)
        
        guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
          touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
            return
        }
        touchedNode.fillColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        if touchedNode.name == "counterClockwiseButton" {
          snake!.moveCounterClockwise()
        } else if touchedNode.name == "clockwiseButton" {
          snake!.moveClockwise()
        }
      }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      for touch in touches {
        let touchLocation = touch.location(in: self)
        
        guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
          touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
            return
        }
        
        touchedNode.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func update(_ currentTime: TimeInterval) {

      snake!.move()
    }
    
    func createApple(){
        let randX  = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)) + 1)
        let randY  = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)) + 1)
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
        score += 1
        ScoreLbl.text = "\(score)"
    }
}

extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
      
      let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
      let collisionObject = bodyes ^ CollisionCategories.SnakeHead
        
      switch collisionObject {
      case CollisionCategories.Apple:
        
        let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
        
        apple?.removeFromParent()
        createApple()
        
        snake?.addBodyPart()
        
        snake?.speed += 0.05
        
        

      // Соприкосновение со стенкой экрана (часть домашнего задания)
      default:
        break
        }
    }
}
