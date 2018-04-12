//
//  BitcoinExchangeRateTests.swift
//  BitcoinExchangeRateTests
//
//  Created by 李祺 on 09/03/2018.
//  Copyright © 2018 Qi Li. All rights reserved.
//

import XCTest
@testable import BitcoinExchangeRate
import Moya
import ObjectMapper



class BitcoinExchangeRateTests: XCTestCase {
    
    var priceHistoryObject = PriceHistoryObject.init()

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        // test the model function
        priceHistoryObject?.bpi = ["2018-01-01":52.25,"2018-01-02":23.57]
        
        XCTAssertTrue((priceHistoryObject?.GetData(ifDateOrPrice: true))!
            == ["2018-01-02","2018-01-01"])
        XCTAssertTrue((priceHistoryObject?.GetData(ifDateOrPrice: false))!
            == ["$ 23.57","$ 52.25"])
    
        NetworkingDataTest()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        
        
        
        
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
         func NetworkingDataTest() {
            // try to convert the json to object and test it 

            var priceHistorNetworkingObeject = PriceHistoryObject.init()


                    let target: NetworkManager = .historicalData(startDate: "2018-02-06", endDate:  "2018-02-19")

    
                    let sampleData = target.sampleData
                    let message = String(data: sampleData, encoding: .utf8)
            

            priceHistorNetworkingObeject = Mapper<PriceHistoryObject>().map(JSONString: message!)
            
                     XCTAssertTrue(priceHistorNetworkingObeject?.disclaimer=="This data was produced from the CoinDesk Bitcoin Price Index. BPI value data returned as USD.")
                     XCTAssertTrue(priceHistorNetworkingObeject?.bpi.count == 14)
            


            

    }

    
}


