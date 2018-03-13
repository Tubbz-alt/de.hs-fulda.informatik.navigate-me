//
//  NEngine.swift
//  Navigation Engine
//
//  Created by mahbub on 2/27/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation
import CoreLocation

// TODO:
// 1. Make DTO for Navigation Engine -> (Distance DTO and Direction DTO)
// 2. Make generic methods of distance matrix that will fit for all usecases
class NEngine: RESTServiceDelegate {
    
    private let googleDirection = GoogleDirectionService()
    private let googleDistance = GoogleDistanceService()
    
    // path graph dictionary -> key = vertex, value = tuple(adjacent vertex, weight)
    private let pathGraphInsideUniversity = [
        "46(E).1" : [
            ("a", 1)
        ],
        "a" : [
            ("b", 3),
            ("c", 5),
            ("d", 4),
            ("p", 2)
        ],
        "b" : [
            ("at", 3),
            ("v", 1)
        ],
        "c" : [
            ("d", 3),
            ("h", 2)
        ],
        "d" : [
            ("e", 1)
        ],
        "e" : [
            ("f", 2),
            ("j", 2)
        ],
        "f" : [
            ("g", 1)
        ],
        "g" : nil,
        "h" : [
            ("i", 1)
        ],
        "i" : nil,
        "j" : [
            ("k", 3)
        ],
        "k" : [
            ("l", 2),
            ("p", 5)
        ],
        "l" : [
            ("m", 1),
            ("Halle-8", 1)
        ],
        "Halle-8": nil,
        "m" : [
            ("n", 1)
        ],
        "n" : [
            ("o", 3),
            ("51(G).1", 1)
        ],
        "51(G).1": nil,
        "o" : [
            ("n", 3),
            ("q", 5)
        ],
        "p" : [
            ("o", 3)
        ],
        "q" : [
            ("r", 1),
            ("s", 2)
        ],
        "r" : nil,
        "s" : [
            ("46(E).3", 1),
            ("t", 2)
        ],
        "46(E).3" : nil,
        "t" : [
            ("u", 2),
            ("ad", 5)
        ],
        "u" : [
            ("v", 2),
            ("w", 1),
            ("ag", 1)
        ],
        "v" : [
            ("46(E).2", 1),
            ("u", 2)
        ],
        "46(E).2" : nil,
        "w" : [
            ("x", 2),
            ("aq", 3)
        ],
        "x" : [
            ("y", 1)
        ],
        "y" : [
            ("z", 3),
            ("ah", 1)
        ],
        "z" : [
            ("aa", 1)
        ],
        "aa" : [
            ("ab", 1),
            ("ao", 2)
        ],
        "ab" : [
            ("ac", 2)
        ],
        "ac" : nil,
        "ad" : [
            ("ae", 1),
            ("t", 5)
        ],
        "ae" : [
            ("ad", 1),
            ("Mensa.1", 1),
            ("ak", 2)
        ],
        "Mensa.1" : nil,
        "af" : [
            ("ae", 2),
            ("ai", 3),
            ("SSC.1", 1)
        ],
        "SSC.1" : nil,
        "ag" : [
            ("af", 1),
            ("ah", 3)
        ],
        "ah" : [
            ("ai", 1),
            ("Bibliothek.1", 1)
        ],
        "Bibliothek.1" : nil,
        "ai" : [
            ("aj", 1),
            ("Bibliothek.2", 1)
        ],
        "Bibliothek.2" : nil,
        "aj" : [
            ("ak", 1),
            ("al", 2)
        ],
        "ak" : [
            ("Mensa.2", 1)
        ],
        "Mensa.2" : nil,
        "al" : [
            ("aj", 2),
            ("an", 5),
        ],
        "am" : [
            ("Geb(P).1", 1),
            ("an", 3),
        ],
        "21(P).1" : nil,
        "an" : [
            ("am", 3),
            ("al", 5),
            ("ao", 3)
        ],
        "ao" : [
            ("20(O).1", 1),
            ("ap", 3),
            ("an", 3)
        ],
        "20(O).1" : nil,
        "ap" : [
            ("19(N).1", 1),
            ("ao", 3),
            ("aa", 2)
        ],
        "19(N).1" : nil,
        "aq" : [
            ("w", 3),
            ("ar", 2),
            ("33(M).1", 1)
        ],
        "33(M).1" : nil, // need to verify gebaude nummer and letter
        "ar" : [
            ("at", 1),
            ("33(M).2", 2),
            ("aq", 2),
            ("as", 2)
        ],
        "33(M).2" : nil, // need to verify gebaude nummer and letter
        "as" : [
            ("ar", 2),
            ("33(M).3", 1)
        ],
        "33(M).3" : nil, // need to verify gebaude nummer and letter
        "at" : [
            ("ar", 1),
            ("c", 1),
            ("b", 3)
        ]
    ]
    
    private var origins: [CLLocationCoordinate2D]?
    private var destinations: [CLLocationCoordinate2D]?
    private var insideUniversityArea = false
    
    // dictionary -> key = vertex, value = tuple(distance, parent, last update time)
    private var pathCalculationMatrix = [String : (distance: Int, parent: String?, time: Date)]()
    
    var delegate: EngineDelegate?
    
    init() {
        
        self.delegate = nil
        self.origins = nil
        self.destinations = nil
        
        self.googleDirection.delegate = self
        self.googleDistance.delegate = self
    }
    
    func getDirection(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
     
        self.googleDirection.get(origin: origin, destination: destination)
    }

    // TODO: actual name will be getDistanceMatrix that will fit for any usecases
//    func getDistanceMatrix(origins: [CLLocationCoordinate2D], destinations: [CLLocationCoordinate2D]) {
    func getDirectionFromDistanceMatrix(origins: [CLLocationCoordinate2D], destinations: [CLLocationCoordinate2D], insideUniversityArea: Bool) {
    
        self.origins = origins
        self.destinations = destinations
        self.insideUniversityArea = insideUniversityArea
        self.googleDistance.get(origins: origins, destinations: destinations)
    }
    
    func handleReceivedDirection(_ direction: GoogleDirection) {
        
        guard "OK" == direction.status else {
                
            print("No Walking Direction is found from Google Directions API.")
            print("Google Directions API Error: \(direction)")
            self.delegate?.processDidAbort(reason: "No Walking Direction is found from Google Map.")
            return
        }
        
        let steps = direction.routes.flatMap({ $0.legs.flatMap({ $0.steps }) })
        
        guard !steps.isEmpty else {
            
            print("No Walking Direction is found from Google Directions API.")
            self.delegate?.processDidAbort(reason: "No Walking Direction is found from Google Map.")
            return
        }
        
        self.delegate?.processDidComplete(then: steps)
    }
    
    func handleReceivedDistance(_ distance: GoogleDistance) {
        
        guard "OK" == distance.status else {
            
            print("No Walking Distance is found from Google Distance API.")
            print("Google Distance API Error: \(distance)")
            self.delegate?.processDidAbort(reason: "No Walking Distance is found from Google Map.")
            return
        }
        
        let elements = distance.rows.flatMap({ $0.elements })
        
        var minIndex = 0
        var minElement = elements[0]
        
        for index in 1 ..< elements.count {
        
            if minElement.distance.value > elements[index].distance.value {
                
                minElement = elements[index]
                minIndex = index
            }
        }
        
        if self.insideUniversityArea {
            
            self.delegate?.processDidComplete(then: self.destinations![minIndex])
            return
        }
        
        self.getDirection(origin: self.origins![0], destination: self.destinations![minIndex])
    }
    
    func dataDidReceive(data: Any) {
        
        switch data {
            
            case let direction as GoogleDirection:
                handleReceivedDirection(direction)
            
            case let distance as GoogleDistance:
                handleReceivedDistance(distance)
            
            default:
                print("Google Maps API Error: No Data is received.")
                self.delegate?.processDidAbort(reason: "No Data is received from Google Map.")
        }
    }
    
    func dataDidFail(reason message: String) {
        
        self.delegate?.processDidAbort(reason: message)
    }
    
    func initializePathCalculationMatrix(for source: String) {
        
        self.pathGraphInsideUniversity.keys.forEach { vertex in
            
            self.pathCalculationMatrix[vertex] = (Int.max, nil, Date())
        }
        
        self.pathCalculationMatrix[source]!.distance = 0
    }
    
    func extractVertexHavingMinDistance() -> (key: String, value: (distance: Int, parent: String?, time: Date)) {
        
        let minDistance = self.pathCalculationMatrix.min(by: { $0.value.distance < $1.value.distance })!.value.distance
        let vertexs = self.pathCalculationMatrix.filter({ $0.value.distance == minDistance })
        let sortedVertexs = vertexs.sorted(by: { $0.value.time < $1.value.time })
        let vertexHavingMinDistance = sortedVertexs.first!
        self.pathCalculationMatrix.remove(at: self.pathCalculationMatrix.index(forKey: vertexHavingMinDistance.key)!)
        
        return vertexHavingMinDistance
    }
    
    func relaxAdjacentVertex(_ adjacentVertex: (String, Int), of vertex: (key: String, value: (distance: Int, parent: String?, time: Date))) {
        
        guard self.pathCalculationMatrix[adjacentVertex.0] != nil else {
            
            return
        }
        
        let totalDistance = vertex.value.distance + adjacentVertex.1
        
        if self.pathCalculationMatrix[adjacentVertex.0]!.distance > totalDistance {
            
            self.pathCalculationMatrix[adjacentVertex.0]!.distance = totalDistance
            self.pathCalculationMatrix[adjacentVertex.0]!.parent = vertex.key
            self.pathCalculationMatrix[adjacentVertex.0]!.time = Date()
        }
    }
    
    func generateShortestPath(from source: String) -> [String : (distance: Int, parent: String?)] {
        
        self.initializePathCalculationMatrix(for: source)
        
        var pathResult = [String : (distance: Int, parent: String?)]()
        
        while !self.pathCalculationMatrix.isEmpty {
            
            let extractedVertex = self.extractVertexHavingMinDistance()
            pathResult[extractedVertex.key] = (extractedVertex.value.distance, extractedVertex.value.parent)
            self.pathGraphInsideUniversity[extractedVertex.key]!?.forEach({ adjacentVertex in
                
                self.relaxAdjacentVertex(adjacentVertex, of: extractedVertex)
            })
        }
        
        return pathResult
    }
}
