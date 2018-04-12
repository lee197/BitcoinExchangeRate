//
//  ViewModel.swift
//  BitcoinExchangeRate
//
//  Created by 李祺 on 18/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//

import Foundation


class BitPriceHistoryViewModel:NSObject{
    
    
    @IBOutlet var bitHistoryPriceClient:BitHistoryPriceClient!

     var priceHistoryObject=PriceHistoryObject()
    
    
    
 

    func fetchData(completion:@escaping ()->()){
        
        bitHistoryPriceClient.requestBitcoinHistoryPriceData{ priceHistoryObject in
            
            self.priceHistoryObject = priceHistoryObject
            
            completion()
        }
        
        }
        
    func numberOfSectionsInTableView(section:Int)->Int{
        
        
        return priceHistoryObject!.bpi.count
        
    }
    
    func dateTextOntheLabel(indexPath:NSIndexPath)->String{
        
        return (priceHistoryObject?.GetData(ifDateOrPrice: true)[indexPath.row])!
        
        
    }
    
    func priceTextOntheLabel(indexPath:NSIndexPath)->String{
        
        return (priceHistoryObject?.GetData(ifDateOrPrice: false)[indexPath.row])!

        
    }
        
    }
    

