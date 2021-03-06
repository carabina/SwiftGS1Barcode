//
//  BarcodeParserTests.swift
//  SwiftGS1Barcode
//
//  Created by Toni Hoffmann on 26.06.17.
//  Copyright © 2017 Toni Hoffmann. All rights reserved.
//

import XCTest
@testable import SwiftGS1Barcode

class BarcodeParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGtinPraser(){
        var node = GS1Node(identifier: "01", type: .FixedLengthBased, fixedValue: 14)
        node = GS1BarcodeParser.parseGS1Node(node: node, data: "010012349993333001")
        XCTAssertEqual(node.value, "00123499933330")
    }
    func testDatePraser(){
        var node = GS1Node(identifier: "01", type: .Date)
        node = GS1BarcodeParser.parseGS1Node(node: node, data: "17210228")
        XCTAssertEqual(node.dateValue, NSDate.from(year: 2021, month: 2, day: 28)) // 17
    }
    func testGroupSeperatorBasedInt(){
        var node = GS1Node(identifier: "03", type: .GroupSeperatorBasedInt)
        node = GS1BarcodeParser.parseGS1Node(node: node, data: "3001\u{1D}12341234")
        XCTAssertEqual(node.value, "01")
        XCTAssertEqual(node.intValue, 1)
        XCTAssertEqual(node.dateValue, nil)
    }
    func testGroupSeperatorBased(){
        var node = GS1Node(identifier: "03", type: .GroupSeperatorBased)
        node = GS1BarcodeParser.parseGS1Node(node: node, data: "3001\u{1D}12341234")
        XCTAssertEqual(node.value, "01")
        XCTAssertEqual(node.intValue, nil)
        XCTAssertEqual(node.dateValue, nil)
    }
    func testGroupSeperatorBasedEndOfString(){
        var node = GS1Node(identifier: "03", type: .GroupSeperatorBased)
        node = GS1BarcodeParser.parseGS1Node(node: node, data: "3001")
        XCTAssertEqual(node.value, "01")
        XCTAssertEqual(node.intValue, nil)
        XCTAssertEqual(node.dateValue, nil)
    }
    
}
