//
//  BitPriceHeaderViewModel.swift
//  BitcoinExchangeRate
//
//  Created by 李祺 on 18/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//

import Foundation

class BitPriceHeaderViewModel:NSObject{
    
    var bitCurrentPriceClient=BitCurrentPriceClient()
    
    var currnetPriceObject=CurrnetPriceObject()

    
 
    
    func fetchData(completion:@escaping ()->()){

        bitCurrentPriceClient.requestCurrnetBitCoinPriceData { currnetPriceObject in

            self.currnetPriceObject=currnetPriceObject

            completion()


        }

        }
    
    func priceTextLabel()->String{
        
        
        return String(format:"%.2f",self.currnetPriceObject!.bpi.eUR.rateFloat)
        
    }
}

