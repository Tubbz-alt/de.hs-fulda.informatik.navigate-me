//
//  StringExtension.swift
//  NavigateMe
//
//  Created by mahbub on 3/8/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation

extension String {
    
    func sumOfAsciiValues() -> Int {
        
        return self.utf8.reduce(0, { result, codeUnit in result + Int(codeUnit) })
    }
    
}
