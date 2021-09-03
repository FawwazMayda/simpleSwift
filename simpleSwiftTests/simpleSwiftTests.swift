//
//  simpleSwiftTests.swift
//  simpleSwiftTests
//
//  Created by Muhammad Fawwaz Mayda on 03/09/21.
//

import XCTest
@testable import simpleSwift

class simpleSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableDataSourceInitWithExpectedAmount() {
        let expectedCount = 20
        let sut = TableViewDataSource(itemCount: expectedCount)
        let actualCount = sut.letterArray.count
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testCollectionDataSourceInitWithExpectedAmount() {
        let expectedCount = 20
        let sut = CollectionViewDataSource(itemCount: expectedCount)
        let actualCount = sut.colorArray.count
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testTableDataSourceIsString() {
        let sut = TableViewDataSource(itemCount: 20)
        for item in sut.letterArray {
            if let testItem = item as String? {
                XCTAssertNotNil(testItem)
            }
        }
    }
    
    func testCollectionDataSourceIsUIColor() {
        let sut = CollectionViewDataSource(itemCount: 20)
        for item in sut.colorArray {
            if let testItem = item as UIColor? {
                XCTAssertNotNil(testItem)
            }
        }
    }
    
    func testViewModelInitWithDataSource() {
        let sut = SimpleSwiftViewModel()
        XCTAssertNotNil(sut.collectionDataSource)
        XCTAssertNotNil(sut.tableDataSource)
    }
    
    func testTableDataSourceChangeEntryIsDifference() {
        let sut = TableViewDataSource(itemCount: 20)
        let randomIndex = Int.random(in: 0..<20)
        let oldValue = sut.letterArray[randomIndex]
        sut.newEntry(at: randomIndex)
        let newValue = sut.letterArray[randomIndex]
        XCTAssertNotEqual(oldValue, newValue)
    }
    
    func testCollectionDataSourceChangeEntryIsDifference() {
        let sut = CollectionViewDataSource(itemCount: 20)
        let randomIndex = Int.random(in: 0..<20)
        let oldValue: UIColor = sut.colorArray[randomIndex]
        sut.newColor(at: randomIndex)
        let newValue: UIColor = sut.colorArray[randomIndex]
        XCTAssertFalse(oldValue.isEqual(newValue))
    }
    
    func testTableChangeEntryDoesntAddANewItem() {
        let sut = TableViewDataSource(itemCount: 20)
        let randomIndex = Int.random(in: 0..<20)
        let countBefore = sut.letterArray.count
        sut.newEntry(at: randomIndex)
        let countAfter = sut.letterArray.count
        XCTAssertEqual(countBefore, countAfter)
    }
    
    func testCollectionChangeEntryDoesntAddANewItem() {
        let sut = CollectionViewDataSource(itemCount: 20)
        let randomIndex = Int.random(in: 0..<20)
        let countBefore = sut.colorArray.count
        sut.newColor(at: randomIndex)
        let countAfter = sut.colorArray.count
        XCTAssertEqual(countBefore, countAfter)
    }

}
