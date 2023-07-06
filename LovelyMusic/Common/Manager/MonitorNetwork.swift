//
//  MonitorNetwork.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 24/08/2022.
//

import UIKit
import Network

class MonitorNetwork {
    static let shared = MonitorNetwork()
    
    private var turnOnNetwork = false
    
    func isConnectedNetwork() -> Bool {
        return turnOnNetwork
    }
    
    func configMonitorNetwork() {
        let monitorNetwork = NWPathMonitor()
        monitorNetwork.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                self.turnOnNetwork = true
            } else {
                self.turnOnNetwork = false
            }
            
            NotificationCenter.default.post(name: Notification.Name.didChangeConnectNetworkActivity, object: nil)
        }
        
        monitorNetwork.start(queue: .main)
    }
}
