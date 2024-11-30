//
//  NetworkMonitor.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import Foundation
import Network

// MARK: - Network Monitor Class

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    var isConnected: Bool = false

    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            if self.isConnected {
                NotificationCenter.default.post(name: .networkAvailable, object: nil)
            }
        }
        monitor.start(queue: queue)
    }
}

extension Notification.Name {
    static let networkAvailable = Notification.Name("networkAvailable")
}
