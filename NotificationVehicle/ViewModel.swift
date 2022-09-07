//
//  4.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 31.08.2022.
//

import Foundation

class VehicleViewModel {
    
    static let instance = VehicleViewModel()
    
    
    var vehicleName : [VehicleData]?
    var vehiclePhoto : [Included]?
    
    func getALLData(completionHandler: @escaping () -> () ) {
        
        guard let url = URL(string: "https://api.npoint.io/8cba956f0adad714c626") else {
            print("FailToUrl")
            return
        }

        
        URLSession.shared.dataTask(with: url) { ( data, response, error ) in
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let finalData = try jsonDecoder.decode(School.self, from: data)
                self.vehicleName = finalData.data
                self.vehiclePhoto = finalData.included
                completionHandler()
            } catch  {
                print(error, "Couldn't be parsed correctly")
            }
                
            

        } .resume()
        
        
        
        
    }

}

