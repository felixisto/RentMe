//
//  NetworkStatus.swift
//  RentMe
//
//  Created by Kristiyan Butev on 14.06.21.
//

import SystemConfiguration
import Combine

protocol NetworkStatusChecker: class {
    var isConnectedPublisher: Published<Bool>.Publisher { get }
    
    func refresh()
}

class NetworkStatus: ObservableObject, NetworkStatusChecker {
    public static let REFRESH_INTERVAL: Double = 5.0
    
    @Published var isConnected: Bool
    
    var isConnectedPublisher: Published<Bool>.Publisher {
        return $isConnected
    }
    
    private let queue = DispatchQueue(label: "com.rentme.NetworkStatus")
    
    init(defaultValue: Bool=true) {
        isConnected = true
        refresh()
        refreshUpdate()
    }
    
    func refresh() {
        weak var weakSelf = self
        
        // Update on background
        queue.async {
            weakSelf?.refreshNow()
        }
    }
    
    private func refreshNow() {
        let newState = isConnectedToNetwork()
        
        if self.isConnected != newState {
            self.isConnected = newState
        }
    }
    
    private func refreshUpdate() {
        refresh()
        
        weak var weakSelf = self
        
        queue.asyncAfter(deadline: DispatchTime.now() + Self.REFRESH_INTERVAL) {
            weakSelf?.refreshUpdate()
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}

class NetworkStatusConstant: NetworkStatus {
    override func isConnectedToNetwork() -> Bool {
        return isConnected
    }
}
