//
//  WarikanInputViewController.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/11.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import UIKit

class WarikanInputViewController: UIViewController, InputMainViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib. 
        print("[InputViewController] viewDidLoad")
        rootViewInit()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func rootViewInit()
    {
        let targetNib = UINib(nibName: "WarikanInputMainView", bundle: nil)
        var topLevelView:WarikanInputMainView

        print("[InputViewController] rootViewInit (private)")

        topLevelView = targetNib.instantiateWithOwner(self, options: nil).first as! WarikanInputMainView
        topLevelView.registerDelegate(self)
        self.view = topLevelView
        
    }
    
    func testButtonTapped() {
        print("[InputMainViewDelegate] testButtonTapped")
        performSegueWithIdentifier("showResultSegue", sender: self)
    }
    
    
}

