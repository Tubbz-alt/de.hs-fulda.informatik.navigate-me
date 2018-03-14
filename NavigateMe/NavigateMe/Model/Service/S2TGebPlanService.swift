//
//  S2TGebPlanService.swift
//  NavigateMe
//
//  Created by mahbub on 1/20/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation

class S2TGebPlanService: RESTService {
    
    static private let networkProtocol = "http"
    static private let host = "193.174.26.57"
    static private let port = 8080
    
    init() {
        
        super.init(with: S2TGebPlanService.networkProtocol, host: S2TGebPlanService.host, port: S2TGebPlanService.port)
    }
    
    override func callbackAfterCompletion(data: Data?, response: URLResponse?, error: Error?) {
        
        if error != nil {
            
            print("Response Error [S2TGebPlanService.swift]: \(error!.localizedDescription)")
            self.delegate?.dataDidFail(reason: "Invalid Response from System2Teach.")
            return
        }
        
        guard let data = data else {
            
            print("Response Error [S2TGebPlanService.swift]: No Data is Found.")
            self.delegate?.dataDidFail(reason: "Invalid Response from System2Teach.")
            return
        }
        
        do {
            
            let s2TGebPlans = try JSONDecoder().decode([S2TGebPlan].self, from: data)
            self.delegate?.dataDidReceive(data: s2TGebPlans)
            
        } catch let jsonError {
            
            print("JSON Error [S2TGebPlanService.swift]: \(jsonError)")
            self.delegate?.dataDidFail(reason: "Unable to decode JSON message from System2Teach.")
        }
    }
    
    func get(of gebs: [String], on date: Date) {
        
        guard !gebs.isEmpty else {
            
            print("Service Error [S2TGebPlanService.swift]: Geb list is Empty.")
            self.delegate?.dataDidFail(reason: "Invalid Request to System2Teach.")
            return
        }
        
        var query = [String : String?]()
        
        query["entryLimit"] = "\(1100)"
        query["nofill"] = "\(1)"
        query["date"] = date.string(format: "dd-MM-yyyy")
        
        let requestUrl = "/hfg/rest/st/getGebPlan/" + gebs.joined(separator: ",") + "/"
        let url = self.generateURL(using: requestUrl, query: query)
        self.processGET(for: url)
    }
    
}
