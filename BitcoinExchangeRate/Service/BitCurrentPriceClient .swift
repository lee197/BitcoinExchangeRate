//
//  BitCurrentPriceClient .swift
//  BitcoinExchangeRate
//
//  Created by 李祺 on 18/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class BitCurrentPriceClient:NSObject{
    

    
//    override init() {
//        _ = Timer.scheduledTimer(timeInterval:30, target: self, selector: #selector(self.requestCurrnetBitCoinPriceData), userInfo: nil, repeats: true)
//    }
    
     func requestCurrnetBitCoinPriceData(completion: @escaping (CurrnetPriceObject?)->()){
        // requesting the current data
        
        let provider = MoyaProvider<NetworkManager>()
        provider.request(.currentprice) { result in
            
            
            switch result
            {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.mapJSON()
                    //convert the json to object directly
                    
                    let currnetPriceObjec = Mapper<CurrnetPriceObject>().map(JSON: data as! [String : Any])!
                    
                    
                        completion(currnetPriceObjec)
                    
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
                completion(nil)

                print("Networking Error"+error.errorDescription!)
                break
            }
        }
        
        
    }
    
}


