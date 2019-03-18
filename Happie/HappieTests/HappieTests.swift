//
//  HappieTests.swift
//  HappieTests
//
//  Created by Femke Offringa on 15/03/2019.
//  Copyright © 2019 femkeo. All rights reserved.
//

import XCTest
@testable import Happie

class HappieTests: XCTestCase {
    
    
    let gameData = GameData()
    let userData = UserData()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUnlockingNextLevel(){
        
    }
    
    func testIfDreamIsBeginSaved(){
        userData.Data = [String: Any]()
        userData.initializeStartingUserData()
        let result : String = userData.result["hair"] as! String
        XCTAssertEqual(result,
                       "Hair1", "The result should be Hair1, but it is \(result)")
    }
    
    func testIfDataIsRetreived(){
        gameData.creatingGames()
        let result = gameData.Games.keys.first
        
        XCTAssertEqual(result, "Categories",
                       "The result should be 'Categpories' but is \(result ?? "not found")")
    }
    
    func testIfScoreHasBeenSaved(){
        
    }
    
    func testSavingOfUserData(){
        
    }
    
    //NoMonitor
    func testNoMonitorTimer(){
        
    }
    
    func testNoMonitorAudio(){
        
    }
    
    func testPropertyReader(){
        
    }
    
    
    
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
