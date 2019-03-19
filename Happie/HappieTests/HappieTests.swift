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
        var data = userData.creatingUserData()
        data["dream"] = "Default dream"
        let result = data["dream"] as! String
        XCTAssertNotEqual(result,
                       "Vul hier je droom in", "The should should not be default")
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
