//
//  5.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 31.08.2022.
//

import Foundation

struct School : Codable {
    var data : [VehicleData]
    var included : [Included]
}

struct VehicleData: Codable {
    
    var attributes: RealData
    var relationships: Relationships
}

struct RealData : Codable {
    var name : String
}

struct Included: Codable {
    var attributes : PreferredPrimaryImageClass
    var id : String
    
    
}

struct PreferredPrimaryImageClass: Codable {
    var url : String
    var rental_id : Int
}

struct Relationships : Codable {
    var primary_image : GeneratorUsageItem
    
}

struct GeneratorUsageItem : Codable {
    
    var data: DAT
}

struct DAT: Codable {
    var id: String
}


