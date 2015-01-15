//
//  MSGameManager.swift
//  MineSweeper
//
//  Created by Genki Ishibashi on 2015/01/15.
//  Copyright (c) 2015年 Genki Ishibashi. All rights reserved.
//

import UIKit

private let sharedInstance = MSGameManager()

class MSGameManager {
   
    class func manager() -> MSGameManager{
        
        return sharedInstance
    }
    
    enum GameLevel:Int{
        case Easy   = 0,
             Normal = 1,
             Hard   = 2
    
        func registerDefaultValue(){
            
            let ud = NSUserDefaults.standardUserDefaults()
            ud.registerDefaults(["Level": self.rawValue])
        }
        
        func save(){
            
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setInteger(self.rawValue, forKey: "Level")
        }
    }
    
    private init(){
        
        GameLevel.Easy.registerDefaultValue()
    }
    
    func currentGameLevel() -> GameLevel{
        
        let ud = NSUserDefaults.standardUserDefaults()
        return GameLevel(rawValue: ud.integerForKey("Level"))!
    }
    
    func getNumRows() -> Int{
        
        switch(currentGameLevel()){
        case .Easy  : return 5
        case .Normal: return 10
        case .Hard  : return 10
        }
    }
    
    func getNumColumns() -> Int{
        
        switch(currentGameLevel()){
        case .Easy  : return 5
        case .Normal: return 10
        case .Hard  : return 15
        }
    }
    
    func getNumMines() -> Int{
        
        switch(currentGameLevel()){
        case .Easy  :return 5
        case .Normal:return 10
        case .Hard  :return 20
        }
    }
}
