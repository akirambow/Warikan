//
//  WarikanItemDetailMainView.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/12.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import UIKit

protocol ItemDetailMainViewDelegate: class {
    func testButtonTapped()
}

class WarikanItemDetailMainView: UIView {
    
    @IBOutlet weak var mTestButton: UIButton!
    
    weak var delegate: ItemDetailMainViewDelegate? = nil
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        print("[ItemDetailMainView] initWithCoder")
    }
    
    @IBAction func onTestButtonTapped(sender: AnyObject) {
        self.delegate?.testButtonTapped()
    }
    
    func registerDelegate(aDelegate:ItemDetailMainViewDelegate)
    {
        delegate = aDelegate
    }
    
}
