//
//  WarikanSavedItemModel.swift
//  Warikan
//
//  Created by 木村旭 on 2015/08/12.
//  Copyright © 2015年 akirambow. All rights reserved.
//

import Foundation

class WarikanSavedItemModel {
    
    private var titleString:String = "NO TITLE"
    private var dateString:String  = "NO DATE"
    private var dateObject:NSDate? = nil
    
    init(aTitle:String!, aDate:NSDate?){
        titleString = aTitle
        if aDate == nil {
            dateObject = NSDate()
        } else {
            dateObject = aDate
        }
        dateString = self.convertDateObjectToDateString(dateObject!)
        
        print("[SavedItemModel] titleString=" + titleString)
        print("[SavedItemModel] dateString =" + dateString)
    }
    
    func getTitle() -> String {
        return titleString
    }
    
    func getDateString() -> String {
        return dateString
    }
    
    func updateTitle(aNewTitle:String?) {
        if aNewTitle != nil {
            titleString = aNewTitle!
        }
    }
    
    func updateDateObject(aDate:NSDate?) {
        if aDate != nil {
            dateObject = aDate
            dateString = convertDateObjectToDateString(dateObject!)
        }
    }
    
    private func convertDateObjectToDateString(aDateObj:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.timeStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        return dateFormatter.stringFromDate(aDateObj)
        
    }
}
