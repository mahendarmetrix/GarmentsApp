//
//  GarmentDataTest.swift
//  GarmentsTests
//
//  Created by Mahedndar Ramidi on 6/7/22.
//

import XCTest
@testable import Garments

class GarmentDataTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGarmentDataModelAndDBinsertion() {
        let date = Date()
        let name = UUID().uuidString
        let garmentData = GarmentData(name:name, creationTime: date)
        XCTAssert(garmentData.name == name, "Name mismatch")
        XCTAssert(garmentData.creationTime == date, "Date mismatch")
        
        CoreDataManager.shared.saveGarmentData(garmentData)
        guard let garment = CoreDataManager.shared.getGarmentWithName(name) else {
            XCTAssert(1==0, "failed to write in DB")
            return
        }
        let garmentData2 = GarmentData(garment: garment)
        XCTAssert(garmentData2.name == name, "Name mismatch")
        XCTAssert(garmentData2.creationTime.timeIntervalSince1970 == date.timeIntervalSince1970, "Date mismatch")
        
    }

}
