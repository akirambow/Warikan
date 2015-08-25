//
//  WarikanInputMainView.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/11.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import UIKit

protocol InputMainViewDelegate: class {
    func testButtonTapped()
}

class WarikanInputMainView: UIView, UITextFieldDelegate {
    
//    @IBOutlet weak var mTestButton: UIButton!
    @IBOutlet weak var mConfirmButton: UIButton!
    @IBOutlet weak var mInputGroupFirst: UIView!
    @IBOutlet weak var mInputGroupSecond: UIView!
    
    @IBOutlet weak var mInputAmountField: UITextField!
    
    private var mInputAmountNumber:Int = 0
    private var mNumberFormatter:NSNumberFormatter = NSNumberFormatter()
    
    weak var delegate: InputMainViewDelegate? = nil
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        print("[InputMainView] initWithCoder")
//        initInpugGroupView()
        mNumberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        mNumberFormatter.groupingSeparator = ","
        mNumberFormatter.groupingSize = 3
    }
    
    override func awakeFromNib() {
        print("[InputMainView] awakeFromNib")
        mInputAmountField.keyboardType = UIKeyboardType.NumberPad
        mInputAmountField.inputAccessoryView = makeAccessoryViewForNumberPad()
        mInputAmountField.delegate = self
        mInputAmountField.backgroundColor = UIColor.whiteColor()
        initInpugGroupView()
    }
    
    @IBAction func onConfirmButtonTapped(sender: AnyObject) {
        self.delegate?.testButtonTapped()
    }
    
    func registerDelegate(aDelegate:InputMainViewDelegate)
    {
        delegate = aDelegate
    }
    
    private func initInpugGroupView(){
        print("[InputMainView] initInputGroupView (private)")
        let targetNib = UINib(nibName: "WarikanInputGroupView", bundle: nil)
        var topLevelView:WarikanInputGroupView = targetNib.instantiateWithOwner(self, options:nil).first as! WarikanInputGroupView
        topLevelView.mGroupNameLabel.text = "Group A"
        mInputGroupFirst.addSubview(topLevelView)
        
        topLevelView = targetNib.instantiateWithOwner(self, options:nil).first as! WarikanInputGroupView
        topLevelView.mGroupNameLabel.text = "Group B"
        mInputGroupSecond.addSubview(topLevelView)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("[InputMainView] textFieldDidBeginEditing")
        textField.text = mInputAmountNumber.description
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("[InputMainView] textFieldShouldReturn")
        if textField.text == "" {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("[InputMainView] textFieldDidEndEditing")
        let newInputString = textField.text!
        mInputAmountNumber = Int(newInputString)!
        let newString = "¥ " + mNumberFormatter.stringFromNumber(NSNumber(integer:mInputAmountNumber))!
        textField.text = newString
        (mInputGroupFirst.subviews.first as! WarikanInputGroupView).updateMaxAmount(mInputAmountNumber)
        (mInputGroupSecond.subviews.first as! WarikanInputGroupView).updateMaxAmount(mInputAmountNumber)
    }

    private func makeAccessoryViewForNumberPad() -> UIView {
        print("makeAccessoryView")
        let screenSize      = UIScreen.mainScreen().applicationFrame
        let accessoryView   = UIView(frame: CGRectMake(0, 0, screenSize.width, 44))
        print("makeAccessoryView:" + screenSize.width.description)
        accessoryView.backgroundColor = UIColor.whiteColor()
        accessoryView.alpha = 1.0
        let closeButton     = UIButton(frame: CGRectMake(screenSize.width - 60, 3, 60, 33))
//        let closeButton     = UIButton(frame: CGRectMake(0, 0, 100, 44))
        closeButton.setTitle("閉じる", forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        closeButton.titleLabel!.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        closeButton.backgroundColor = UIColor.whiteColor()
        closeButton.addTarget(self, action: Selector("onKeyboardCloseButtonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        closeButton.alpha = 1.0
        accessoryView.addSubview(closeButton)
        
        return accessoryView
    }
    
    func onKeyboardCloseButtonTapped(sendor:AnyObject) {
        mInputAmountField.resignFirstResponder()
    }
    
}
