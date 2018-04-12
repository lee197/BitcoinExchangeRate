//
//  PriceHistoryObject.swift
//  BitcoinExchangeRate
//
//  Created by 李祺 on 09/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//

import Foundation
import ObjectMapper

struct PriceHistoryObject:Mappable{
    
    var bpi:[String:Double]
    var disclaimer:String
    var time:UpdateTimeObject
    
    
}

struct UpdateTimeObject:Mappable{
    
    
    var updated:String
    
    var updatedISO:String
    
    
    
}

extension UpdateTimeObject {
    init?(map: Map) {

        self.updated = ""
        self.updatedISO = ""

    }
    
    init(updated1:String,updatedISO1:String) {
        
        self.updated = updated1
        self.updatedISO = updatedISO1
        
    }
    
    
    mutating func mapping(map: Map) {
        
        self.updated <- map["updated"]
        self.updatedISO <- map["updatedISO"]
        
    }
}
extension PriceHistoryObject {

    // MARK: JSON
    init?(map: Map) {
        
        self.bpi = [String:Double]()
        self.disclaimer = ""
        self.time = UpdateTimeObject(updated1:"",updatedISO1:"")
        
    }
    
    init?() {
        
        self.bpi = [String:Double]()
        self.disclaimer = ""
        self.time = UpdateTimeObject(updated1:"",updatedISO1:"")

        
    }
    
    
    mutating func mapping(map: Map) {
        
        bpi <- map["bpi"]
        disclaimer <- map["disclaimer"]
        time <- map["time"]
        
    }
    
    
    /**
     Get the date or price array
     
     Sample usage:
     let date = GetData(ifDateOrPrice:true)
     
     - parameter ifDateOrPrice:  true means requesting sorted date,false means requesting price
     
     - returns: date or price array.
     */
    
    func GetData(ifDateOrPrice:Bool)->[String]{
        
        let keyArray = Array(bpi.keys).sorted(by: { $0.compare($1) == .orderedDescending })
        
        if  ifDateOrPrice == true{
            
            return keyArray
            
            
        }else{
            
       //function programming practise
            
         return keyArray.map{ key in
                return "$ "+String(format: "%.2f",bpi[key]!)
            }
        }
       
    }
    
    
}
