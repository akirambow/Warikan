//
//  WarikanResultMainView.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/12.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import UIKit

protocol ResultMainViewDelegate: class {
    func testButtonTapped()
}

class WarikanResultMainView: UIView {
    
    @IBOutlet weak var mTestButton: UIButton!
    
    weak var delegate: ResultMainViewDelegate? = nil
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        print("[ResultMainView] initWithCoder")
    }
    
    @IBAction func onTestButtonTapped(sender: AnyObject) {
        self.delegate?.testButtonTapped()
    }
    
    func registerDelegate(aDelegate:ResultMainViewDelegate)
    {
        delegate = aDelegate
    }
    
}
