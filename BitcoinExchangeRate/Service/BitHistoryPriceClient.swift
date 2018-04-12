//
//  BitHistoryPriceClient.swift
//  BitcoinExchangeRate
//
//  Created by 李祺 on 18/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class BitHistoryPriceClient:NSObject{
    

    func requestBitcoinHistoryPriceData(completion:@escaping (PriceHistoryObject?)->()) {
        
        //Get the two week's ago date
        var twoWeeksfromNow: String {
            
            let lastTwoWeeksDate =  (Calendar.current as NSCalendar).date(byAdding: .day, value: -14, to: Date(), options: [])!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let lastWeeksDateString = dateFormatter.string(from: lastTwoWeeksDate)
            
            return lastWeeksDateString
        }
        //Get the current date
        
        var currnetDate: String{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDateString = dateFormatter.string(from: Date())
            
            return currentDateString
            
        }
        
        // requesting the history data
        let provider = MoyaProvider<NetworkManager>()
        provider.request(.historicalData(startDate: currnetDate, endDate: twoWeeksfromNow)) { result in
            
            
            switch result
            {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.mapJSON()
                    //convert the json to object directly
                    print(data)
                    let priceHistoryObject = Mapper<PriceHistoryObject>().map(JSON: data as! [String : Any])!
                    
                    completion(priceHistoryObject)
                    return
                }
                catch {
                    completion(nil)
                    print("error happened on converting Json")
                    return
                }
                
            case let .failure(error):
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
                
                print("Networking Error"+error.errorDescription!)
                
                break
            }
        }
    }
    
    
}
