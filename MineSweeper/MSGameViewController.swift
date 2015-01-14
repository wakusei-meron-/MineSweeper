//
//  MSGameViewController.swift
//  MineSweeper
//
//  Created by Genki Ishibashi on 2015/01/08.
//  Copyright (c) 2015年 Genki Ishibashi. All rights reserved.
//

import UIKit

class MSGameViewController: UIViewController, UIAlertViewDelegate{

    enum MSMode{
        
        case Open, CheckMine, Unknown
    }
    
    @IBOutlet weak var mineModeButton: UIButton!
    @IBOutlet weak var unknownModeButton: UIButton!
    @IBOutlet weak var fieldView: MSGameFieldView!
    
    var currentMSMode = MSMode.Open
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "buttonDidClick:", name: "clickButton", object: nil)
        nc.addObserver(self, selector: "mineButtonDidClick", name: "clickMine", object: nil)
    }
    
    @IBAction func mineModeButtonDidClick(sender: AnyObject) {
        
        switch(currentMSMode){
        case .Open:
            currentMSMode = .CheckMine
        case .CheckMine:
            currentMSMode = .Open
        case .Unknown:
            currentMSMode = .CheckMine
        }
        
        changeModeButtonBackgroundColor(currentMSMode)
    }
    
    @IBAction func unknownModeButtonDidClick(sender: AnyObject) {
        
        switch(currentMSMode){
        case .Open:
            currentMSMode = .Unknown
        case .CheckMine:
            currentMSMode = .Unknown
        case .Unknown:
            currentMSMode = .Open
        }
        
        changeModeButtonBackgroundColor(currentMSMode)
    }
    
    func changeModeButtonBackgroundColor(mode:MSMode){
        
        switch(mode){
        case .Open:
            mineModeButton.backgroundColor   = UIColor.whiteColor()
            unknownModeButton.backgroundColor = UIColor.whiteColor()
        case .CheckMine:
            mineModeButton.backgroundColor    = UIColor.grayColor()
            unknownModeButton.backgroundColor = UIColor.whiteColor()
        case .Unknown:
            mineModeButton.backgroundColor    = UIColor.whiteColor()
            unknownModeButton.backgroundColor = UIColor.grayColor()
        }
    }
    
    // MARK: Notification from MSButton
    func buttonDidClick(nc: NSNotification ){

        if let userInfo = nc.userInfo {
            
            let row = userInfo["row"] as Int
            let col = userInfo["column"] as Int
            
            let selectedButton = fieldView.buttonArray[row][col] as MSButton
            
            switch(currentMSMode){
            case .Open:
                selectedButton.open()
            case .CheckMine:
                selectedButton.checkMineToggle()
            case .Unknown:
                selectedButton.unknownToggle()
            }
            
            if fieldView.isCleared(){
                
                UIAlertView(title: "クリアしました", message: "おめでとう", delegate: self, cancelButtonTitle: "OK").show()
            }
        }
    }
    
    func mineButtonDidClick(){
        
        UIAlertView(title: "", message: "ゲームオーバー", delegate: self, cancelButtonTitle: "OK").show()
    }
    
    // MARK: UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
