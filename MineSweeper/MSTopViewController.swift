//
//  MSViewController.swift
//  MineSweeper
//
//  Created by Genki Ishibashi on 2015/01/08.
//  Copyright (c) 2015年 Genki Ishibashi. All rights reserved.
//

import UIKit

class MSTopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func playGame(sender: UIButton) {
        
        let gvc = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            .instantiateViewControllerWithIdentifier("GameVC") as MSGameViewController
        self.presentViewController(gvc, animated: true, completion: {
            
            gvc.fieldView.setupButtons()
        })
        
    }
}
