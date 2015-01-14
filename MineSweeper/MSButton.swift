//
//  MSButton.swift
//  MineSweeper
//
//  Created by Genki Ishibashi on 2015/01/08.
//  Copyright (c) 2015年 Genki Ishibashi. All rights reserved.
//

import UIKit

class MSButton: UIButton {
    
    let kButtonBorderWidth: CGFloat = 0.5
    
    let defaultButtonTitle = ""
    let mineButtonTitle = "Mine"
    let mineCheckedButtonTitle = "Danger"
    let unknownCheckedButtonTitle = "?"
    
    var row: Int = -1, column: Int = -1
    var numAroundMine: Int = 0
    var isMine = false
    
    var msState = MSButtonState.unOpened
    
    enum MSButtonState{
        case unOpened, opened, mineChecked, unknown
    }
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: "onClickedButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.setTitle(defaultButtonTitle, forState: UIControlState.Normal)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.layer.borderWidth = kButtonBorderWidth
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func onClickedButton(){
        
        let dic = NSDictionary(objects: [row, column], forKeys: ["row","column"])
        let nc = NSNotification(name: "clickButton", object: self, userInfo: dic)
        NSNotificationCenter.defaultCenter().postNotification(nc)
    }

    func open(){
        
        switch(self.msState){
        case .unOpened:
            
            msState = MSButtonState.opened
            self.setTitle("\(numAroundMine)", forState: UIControlState.Normal)
            
            if isMine {
                self.setTitle(mineButtonTitle, forState: UIControlState.Normal)
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "clickMine", object: nil))
            }
        case .opened:
            break
        case .mineChecked:
            break
        case .unknown:
            break
        }
    }
    
    func checkMineToggle(){
        
        switch(msState){
        case .unOpened:
            msState = .mineChecked
            self.setTitle(mineCheckedButtonTitle, forState: UIControlState.Normal)
        case .mineChecked:
            msState = .unOpened
            self.setTitle(defaultButtonTitle, forState: UIControlState.Normal)
        default:
            break
        }
    }
    
    func unknownToggle(){
        
        switch(msState){
        case .unOpened:
            msState = .unknown
            self.setTitle(unknownCheckedButtonTitle, forState: UIControlState.Normal)
        case .unknown:
            msState = .unOpened
            self.setTitle(defaultButtonTitle, forState: UIControlState.Normal)
        default:
            break
        }
    }
}