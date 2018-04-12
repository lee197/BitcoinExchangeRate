//
//  currnetPriceObject.swift
//  BitcoinExchangeRate
//
//  Created by 李祺 on 11/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//


import Foundation
import ObjectMapper

struct CurrnetPriceObject: Mappable{
   
    
    var time: Time
    var disclaimer: String
    var chartName: String
    var bpi: Bpi
    
 
}

struct Bpi: Mappable {
    var usd: Currency
    var gbp: Currency
    var eUR: Currency
    
    
}

struct Currency: Mappable {
   
    
    var code: String
    var symbol: String
    var rate: String
    var description: String
    var rateFloat: Double
    
   
}

struct Time: Mappable {
    var updated: String
    var updatedISO: String
    var updateduk: String
    
 
}

// MARK: Convenience initializers

extension CurrnetPriceObject {
    
    mutating func mapping(map: Map) {
        self.time <- map["time"]
        self.disclaimer <- map["disclaimer"]
        self.chartName <- map["chartName"]
        self.bpi <- map["bpi"]
    }
    
    init?(map: Map) {
        self.time = Time(bitUpdated:"",bitUpdatedISO:"",bitUpdateuk:"")!
        self.bpi = Bpi()!
        self.disclaimer = ""
        self.chartName = ""
    }
    
    init?() {
        self.time = Time(bitUpdated:"",bitUpdatedISO:"",bitUpdateuk:"")!
        self.bpi = Bpi()!
        self.disclaimer = ""
        self.chartName = ""
    }
}

extension Bpi {
    mutating func mapping(map: Map) {
        self.usd <- map["USD"]
        self.gbp <- map["GBP"]
        self.eUR <- map["EUR"]
    }
    
    init?(map: Map) {
        self.usd = Currency(bitCode:"",bitSymbol:"",bitRate:"",bitDescription:"",bitRateFloat:0.0)!
        self.gbp = Currency(bitCode:"",bitSymbol:"",bitRate:"",bitDescription:"",bitRateFloat:0.0)!
        self.eUR = Currency(bitCode:"",bitSymbol:"",bitRate:"",bitDescription:"",bitRateFloat:0.0)!
    }
    
    init?() {
        self.usd = Currency(bitCode:"",bitSymbol:"",bitRate:"",bitDescription:"",bitRateFloat:0.0)!
        self.gbp = Currency(bitCode:"",bitSymbol:"",bitRate:"",bitDescription:"",bitRateFloat:0.0)!
        self.eUR = Currency(bitCode:"",bitSymbol:"",bitRate:"",bitDescription:"",bitRateFloat:0.0)!
    }
}

extension Currency {
    mutating func mapping(map: Map) {
        self.code <- map["code"]
        self.symbol <- map["symbol"]
        self.rate <- map["rate"]
        self.description <- map["description"]
        self.rateFloat <- map["rate_float"]
    }
    
    init?(map: Map) {
        self.code = ""
        self.symbol = ""
        self.rate = ""
        self.description = ""
        self.rateFloat = 0.0
    }
    
    init?(bitCode:String,bitSymbol:String,bitRate:String,bitDescription:String,bitRateFloat:Double) {
        self.code = bitCode
        self.symbol = bitSymbol
        self.rate = bitRate
        self.description = bitDescription
        self.rateFloat = bitRateFloat
    }
}

extension Time {
    mutating func mapping(map: Map) {
        
        self.updated <- map["updated"]
        self.updatedISO <- map["updatedISO"]
        self.updateduk <- map["updateduk"]
    }
    
    init?(map: Map) {
        
        self.updated = ""
        self.updatedISO = ""
        self.updateduk = ""

    }
    
    init?(bitUpdated:String,bitUpdatedISO:String,bitUpdateuk:String) {
        self.updated = bitUpdated
        self.updatedISO = bitUpdatedISO
        self.updateduk = bitUpdateuk
    }
}

