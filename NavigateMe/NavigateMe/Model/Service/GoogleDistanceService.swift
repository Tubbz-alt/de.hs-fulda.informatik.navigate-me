//
//  GoogleDistanceService.swift
//  NavigateMe
//
//  Created by mahbub on 3/7/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation
import CoreLocation

class GoogleDistanceService: RESTService {
    
    static private let networkProtocol = "https"
    static private let host = "maps.googleapis.com"
    
    init() {
        
        super.init(with: GoogleDistanceService.networkProtocol, host: GoogleDistanceService.host)
    }
    
    override func callbackAfterCompletion(data: Data?, response: URLResponse?, error: Error?) {
        
        if error != nil {
            
            print("Response Error: \(error!.localizedDescription)")
            return
        }
        
        guard let data = data else {
            
            print("Response Data: No Data is Found.")
            return
        }
        
        do {
            
            let googleDistance = try JSONDecoder().decode(GoogleDistance.self, from: data)
            self.delegate?.dataDidReceive(data: googleDistance)
            
        } catch let jsonError {
            
            print("JSON Error:\(jsonError)")
        }
    }
    
    func get(origins: [CLLocationCoordinate2D], destinations: [CLLocationCoordinate2D]) {
        
        var query = [String : String?]()

        query["origins"] = origins.map({ "\($0.latitude),\($0.longitude)" }).joined(separator: "|")
        query["destinations"] = destinations.map({ "\($0.latitude),\($0.longitude)" }).joined(separator: "|")
        query["key"] = "AIzaSyA5WKLZCTreqWGGVNdeucTzqCgsLfEf8CU"
        query["mode"] = "walking"
        
        let requestUrl = "/maps/api/distancematrix/json"
        let url = self.generateURL(using: requestUrl, query: query)
        
        self.processGET(for: url)
    }
    
}
