//
//  NetworkManager.swift
//  BitcoinExchangeRate
//
//  Created by 李祺 on 09/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//


import Foundation
import Moya

// 2 types of networking request, one is for current data, another is for histiry data
enum NetworkManager {
    
    case historicalData(startDate:String,endDate:String)
    case currentprice

    
    
}

// MARK: - TargetType Protocol Implementation
extension NetworkManager: TargetType {
    
    //specify the url
    
    var baseURL: URL { return URL(string: "https://api.coindesk.com/v1/bpi")! }
    
    
    var path: String {
        
        switch self {
            
        case .historicalData(startDate:_,endDate:_):
            return "/historical/close.json"
            
        case .currentprice:
            return "/currentprice.json"
            
      
        }
    }
    
    //specified the method
    var method: Moya.Method {
        switch self {
        case .historicalData, .currentprice:
            return .get
      
        }
    }
    //include the parameters
    var task: Task {
        
        switch self {
            
        case .currentprice:
            return .requestPlain
     
        case .historicalData(let startDate, let endDate): // Send no parameters
            
            
            return .requestParameters(parameters: ["end": startDate,"start": endDate], encoding: URLEncoding.queryString)
            
 
    }
    }
    // this sample data is used for test
    var sampleData: Data {
        switch self {
            
        case .currentprice:
            
            
            return "{\"time\": {\"updated\": \"Mar 9, 2018 13:30:00 UTC\",\"updatedISO\": \"2018-03-09T13:30:00+00:00\",\"updateduk\": \"Mar 9, 2018 at 13:30 GMT\"},\"disclaimer\": \"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org\",\"chartName\": \"Bitcoin\",\"bpi\": {\"USD\": {\"code\": \"USD\",\"symbol\": \"&#36;\",\"rate\": \"8,885.2113\",\"description\": \"United States Dollar\",\"rate_float\": 8885.2113},\"GBP\": {\"code\": \"GBP\",\"symbol\": \"&pound;\",\"rate\": \"6,423.8478\",\"description\": \"British Pound Sterling\",\"rate_float\": 6423.8478},\"EUR\": {\"code\": \"EUR\",\"symbol\": \"&euro;\",\"rate\": \"7,226.4400\",\"description\": \"Euro\",\"rate_float\": 7226.44}}}".utf8Encoded
            
            
        case .historicalData:
            

            
            return "{\"bpi\": {\"2018-02-06\": 7700.3863,\"2018-02-07\": 7581.8038,\"2018-02-08\": 8237.2363,\"2018-02-09\": 8689.8388,\"2018-02-10\": 8556.6125,\"2018-02-11\": 8070.7963,\"2018-02-12\": 8891.2125,\"2018-02-13\": 8516.2438,\"2018-02-14\": 9477.84,\"2018-02-15\": 10016.4888,\"2018-02-16\": 10178.7125,\"2018-02-17\": 11092.1475,\"2018-02-18\": 10396.63,\"2018-02-19\": 11159.7238},\"disclaimer\": \"This data was produced from the CoinDesk Bitcoin Price Index. BPI value data returned as USD.\",\"time\": {\"updated\": \"Mar 9, 2018 00:03:00 UTC\",\"updatedISO\": \"2018-03-09T00:03:00+00:00\"}}".utf8Encoded
     
        }
    }
    
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
