//
//  NetworkMonitor.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Network


enum ConnectionType{
    case connected
    case connectionError
}

class NetworkMonitor {
    
    private init(){}
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    func startMonitoring(status: @escaping (ConnectionType) -> Void) {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            if path.status == .satisfied {
                status(.connected)
            } else {
                status(.connectionError)
            }
            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
