//
//  PropertyListExerciseUITests.swift
//  PropertyListExerciseUITests
//
//  Created by Josman Pérez Expósito on 28/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import XCTest

class PropertyListExerciseUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        
        app.launchArguments.append("--uitesting")

       
    }

    override func tearDown() {
        
    }

    func testFirstProperty() {
        app.launch()
        
        // Grab the first element in the table using the title
        var element = app.tables.staticTexts["STF Vandrarhem Stigbergsliden"]
        
        let exists = NSPredicate(format: "exists == true")
        // Wait for the WS to complete the request
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        // The first return property is the expected
        XCTAssertTrue(element.exists)
        // Go to detail screen
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["STF Vandrarhem Stigbergsliden"]/*[[".cells.staticTexts[\"STF Vandrarhem Stigbergsliden\"]",".staticTexts[\"STF Vandrarhem Stigbergsliden\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        element = app.staticTexts["STF Vandrarhem Stigbergsliden"]
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        // Title
        XCTAssertTrue(element.exists)
        // City
        XCTAssertTrue(app.staticTexts["Gothenburg, Sweden"].exists)
        // Rating
        XCTAssertTrue(app.staticTexts["82"].exists)
        
    }
    
    

}
