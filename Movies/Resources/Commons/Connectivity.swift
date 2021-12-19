//
//  Connectivity.swift
//  Movies
//
//  Created by Mujahid Ali on 18/12/21.
//

import Foundation
import Alamofire
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
