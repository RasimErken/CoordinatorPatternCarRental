//
//  Coordinator.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 1.09.2022.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
    
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
