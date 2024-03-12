//
//  Connectivity.swift
//  TestProject
//
//  Created by Alexandr Kudlak on 12.03.2024.
//

import Network

class Connectivity {
    static let shared = Connectivity()
    private var monitor: NWPathMonitor?
    private var isMonitoring = false
    private(set) var isConnected: Bool = false

    func startMonitoring() {
        guard !isMonitoring else { return }

        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor?.start(queue: queue)

        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }

        isMonitoring = true
    }

    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
    }
}

