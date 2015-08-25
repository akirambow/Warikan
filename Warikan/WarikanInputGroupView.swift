//
//  WarikanInputGroupView.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/13.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import UIKit

protocol InputGroupViewDelegate: class {
    func testButtonTapped()
}

class WarikanInputGroupView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var mConfirmButton: UIButton!
    
    @IBOutlet weak var mGroupNameLabel: UILabel!
    @IBOutlet weak var mGroupNameInputField: UITextField!
    @IBOutlet weak var mIncrementButton: UIButton!
    @IBOutlet weak var mCountInputField: UITextField!
    @IBOutlet weak var mDecrementButton: UIButton!
    @IBOutlet weak var mAdjustAmountSlider: UISlider!
    @IBOutlet weak var mPerAmountLabel: UILabel!
    
    private var mCountNumber:Int = 0
    private var mMaxAmount:Int = 0
    private var mIsCountEditing:Bool = false
    private var mNumberFormatter:NSNumberFormatter = NSNumberFormatter()
    
    private let mInputAttrTextDefault  = NSMutableAttributedString(string: "グループ名など入力")
    private let mInputAttrTextInittext = NSMutableAttributedString(string: "")
    private let DEFAULT_STRING_FOR_INPUT:String = "グループ名など入力"
    
    weak var delegate: InputMainViewDelegate? = nil
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        mNumberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        mNumberFormatter.groupingSeparator = ","
        mNumberFormatter.groupingSize = 3
        print("[InputGroupView] initWithCoder")
    }
    
    override func awakeFromNib() {
        mCountInputField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        mCountInputField.delegate = self
        mCountInputField.backgroundColor = UIColor.whiteColor()
        mGroupNameInputField.delegate = self
        mGroupNameInputField.backgroundColor = UIColor.whiteColor()
        mAdjustAmountSlider.maximumValue = 1.0
        mAdjustAmountSlider.minimumValue = 0.0
        mAdjustAmountSlider.value = 0.0
        mAdjustAmountSlider.enabled = false
        mAdjustAmountSlider.addTarget(self, action: Selector("sliderValueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        
        mInputAttrTextDefault.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, 9))
        mInputAttrTextInittext.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, 0))
        mGroupNameInputField.attributedText = mInputAttrTextDefault
        
        print("[InputGroupView] awakeFromNib")
    }
    
    @IBAction func onConfirmButtonTapped(sender: AnyObject) {
        self.delegate?.testButtonTapped()
    }
    
    func registerDelegate(aDelegate:InputMainViewDelegate)
    {
        delegate = aDelegate
    }
    
    @IBAction func onIncrementButtonTapped(sender: AnyObject) {
        if !mIsCountEditing && mCountNumber < 99 {
            mCountNumber++
            updateCountInputField()
        }
    }
    
    @IBAction func onDecrementButtonTapped(sender: AnyObject) {
        if !mIsCountEditing && mCountNumber > 0 {
            mCountNumber--
            updateCountInputField()
        }
    }
    
    @IBAction func onAdjustSliderMoved(sender: AnyObject) {
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == mCountInputField {
            print("[InputGroupView] textFieldDidBeginEditing")
            mIsCountEditing = true
            textField.text = mCountNumber.description
        }
        
        if textField == mGroupNameInputField {
            if textField.attributedText!.string == DEFAULT_STRING_FOR_INPUT {
                textField.attributedText = mInputAttrTextInittext
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == mCountInputField {
            print("[InputGroupView] textFieldShouldReturn")
            if textField.text == "" {
                return false
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == mCountInputField {
            print("[InputGroupView] textFieldDidEndEditing")
            let newInputString = textField.text!
            mCountNumber = Int(newInputString)!
            if mCountNumber > 99 {
                mCountNumber = 99
            }
            if mCountNumber < 0 {
                mCountNumber = 0
            }
            let newString = mCountNumber.description + " 人"
            textField.text = newString
            mIsCountEditing = false
            updateSliderValueIfNeeded()
        }
        
        if textField == mGroupNameInputField {
            if textField.attributedText!.string == "" {
                textField.attributedText = mInputAttrTextDefault
            }
        }

    }
    
    private func updateCountInputField() {
        let newCountString = mCountNumber.description + " 人"
        mCountInputField.text = newCountString
    }
    
    private func updateSliderValueIfNeeded(){
        if mMaxAmount > 0 && mCountNumber > 0 {
            let currentMaxValue = mAdjustAmountSlider.maximumValue
            let newMaximumValue = Float(mMaxAmount) / Float(mCountNumber)
            
            if newMaximumValue < 1.0 {
                mAdjustAmountSlider.value = 0.0
                mAdjustAmountSlider.maximumValue = 1.0
                mAdjustAmountSlider.enabled = false
            } else {
                mAdjustAmountSlider.value = mAdjustAmountSlider.value * newMaximumValue / currentMaxValue
                mAdjustAmountSlider.maximumValue = newMaximumValue
                mAdjustAmountSlider.enabled = true
            }
        } else {
            mAdjustAmountSlider.value = 0.0
            mAdjustAmountSlider.maximumValue = 1.0
            mAdjustAmountSlider.enabled = false
        }
        sliderValueChanged()
    }
    
    func updateMaxAmount(aAmount:Int){
        mMaxAmount = aAmount
        updateSliderValueIfNeeded()
    }
    
    func sliderValueChanged() {
        let perAmountInt = Int(mAdjustAmountSlider.value)
        mPerAmountLabel.text = "一人あたり金額　¥ " + mNumberFormatter.stringFromNumber(NSNumber(integer:perAmountInt))!
    }
}
