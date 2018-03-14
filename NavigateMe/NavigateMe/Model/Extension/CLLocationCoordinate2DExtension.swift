//
//  CLLocationCoordinate2DExtension.swift
//  NavigateMe
//
//  Created by mahbub on 3/8/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Hashable {
    
    public var hashValue: Int {
        
        return "\(self.latitude),\(self.longitude)".sumOfAsciiValues()
    }
    
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        
        return lhs.hashValue == rhs.hashValue
    }
    
}
