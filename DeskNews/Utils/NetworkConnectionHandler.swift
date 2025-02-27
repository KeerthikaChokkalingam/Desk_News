//
//  Network Checking.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 25/08/23.
//

import Foundation
import SystemConfiguration
import Network

class NetworkConnectionHandler {
    private let mReachability = SCNetworkReachabilityCreateWithName(nil, "https://www.google.com")
    func checkReachable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.mReachability!, &flags)
        if isNetworkReachable(with: flags) {
            return true
        } else {
            return false
        }
    }
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        return isReachable
    }
}
