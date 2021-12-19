//
//  String + Extensions.swift
//  Movies
//
//  Created by Mujahid Ali on 18/12/21.
//

import Foundation
import UIKit

extension String {
}

extension UIViewController {
    static var indentifire: String {
        get {
            return String(describing: self)
        }
    }
}

extension UITableViewCell {
    static var indentifire: String {
        get {
            return String(describing: self)
        }
    }
}
