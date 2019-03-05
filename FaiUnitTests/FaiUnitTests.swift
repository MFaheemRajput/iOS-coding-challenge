//
//  FaiUnitTests.swift
//  FaiUnitTests
//
//  Created by Muhammad Faheem on 03/03/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import XCTest
import Alamofire
@testable import JodelChallenge


class FaiUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testImageDownloading(){
//        let photoVM =  PhotosViewModel()
//        photoVM.loadPicture()
    }
    
    func  testIndicatorIsAnimating(){
        let photoVM =  PhotosViewModel()
        photoVM.startAnimation()
        if let value = photoVM.indicatorView?.isAnimating{
            XCTAssertEqual(value, true)
            XCTAssertTrue(value)
        }

    }
    func  testIndicatorIsNotAnimating(){
        let photoVM =  PhotosViewModel()
        photoVM.stopAnimation()
        if let value = photoVM.indicatorView?.isAnimating{
            print("yahoo\(value)")
            XCTAssertEqual(value, false)
            XCTAssertFalse(value)
        }
    }
    
    func testInternetIsNoConnected(){
        
        NetworkManager.isReachable { networkManagerInstance in
            XCTAssertTrue(true)
        }
    }
    
}
