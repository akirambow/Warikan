//
//  WarikanResultViewController.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/12.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import UIKit

class WarikanResultViewController: UIViewController, ResultMainViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rootViewInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func rootViewInit()
    {
        let targetNib = UINib(nibName: "WarikanResultMainView", bundle: nil)
        var topLevelView:WarikanResultMainView
        
        print("[ResultViewController] rootViewInit (private)")
        
        topLevelView = targetNib.instantiateWithOwner(self, options: nil).first as! WarikanResultMainView
        topLevelView.registerDelegate(self)
        self.view = topLevelView
        
    }
    
    func testButtonTapped() {
        print("[ResultMainViewDelegate] testButtonTapped")
    }
    
}

