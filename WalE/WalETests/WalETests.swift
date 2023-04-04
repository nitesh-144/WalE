//
//  WalETests.swift
//  WalETests
//
//  Created by Deepika Vyas on 04/04/23.
//

import XCTest
@testable import WalE

final class WalETests: XCTestCase {

    let sut = CommonService(withApiService: ApiClient.shared, offlineStore: OfflineStore.shared)
    
    func test_whenNoInternet(){
        let expectation = expectation(description: "no_internet_checking")
        sut.getImageOfTheDay { imageData in
    
            XCTAssertEqual(self.sut.errorFlag, .internetConnectionError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_whenNoInternet_NoPastData(){
        let expectation = expectation(description: "no_internet_nodata_checking")
        sut.getImageOfTheDay { imageData in
    
            XCTAssertEqual(self.sut.errorFlag, .apiServiceError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_whenNoInternet_withPastData(){
        let expectation = expectation(description: "no_internet_withData_checking")
        sut.getImageOfTheDay { imageData in
    
            XCTAssertEqual(self.sut.isPastData, true)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
}
