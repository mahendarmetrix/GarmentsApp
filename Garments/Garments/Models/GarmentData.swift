//
//  GarmentData.swift
//  Garments
//
//  Created by Mahedndar Ramidi on 6/7/22.
//

import Foundation

class GarmentData {
    let name: String
    let creationTime: Date
    
    init(garment: Garment) {
        self.name = garment.name
        self.creationTime = garment.creationTime
    }
    
    init(name: String, creationTime: Date) {
        self.name = name
        self.creationTime = creationTime
    }
}

enum SortType: String {
    case name
    case creationTime
}
