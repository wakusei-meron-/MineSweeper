//
//  MSViewController.swift
//  MineSweeper
//
//  Created by Genki Ishibashi on 2015/01/08.
//  Copyright (c) 2015年 Genki Ishibashi. All rights reserved.
//

import UIKit

class MSTopViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLevelButtonBackGroundColor()
    }
    
    @IBAction func playGame(sender: UIButton) {
        
        let gvc = UIStoryboard(name: "MSMain", bundle: NSBundle.mainBundle())
            .instantiateViewControllerWithIdentifier("GameVC") as MSGameViewController
        self.presentViewController(gvc, animated: true, completion: {
            
            gvc.fieldView.setupButtons()
        })
    }
    
    @IBAction func levelButtonDidClick(sender: UIButton) {
        
        MSGameManager.GameLevel(rawValue: sender.tag)?.save()
        setLevelButtonBackGroundColor()
    }
    
    
    func setLevelButtonBackGroundColor(){
        
        let unSelectedColor = UIColor.whiteColor()
        let selectedColor   = UIColor.grayColor()
        
        easyButton.backgroundColor   = unSelectedColor
        normalButton.backgroundColor = unSelectedColor
        hardButton.backgroundColor   = unSelectedColor
        
        let m = MSGameManager.manager()
        switch(m.currentGameLevel()){
        case .Easy  : easyButton.backgroundColor   = selectedColor
        case .Normal: normalButton.backgroundColor = selectedColor
        case .Hard  : hardButton.backgroundColor   = selectedColor
        }
    }
}
