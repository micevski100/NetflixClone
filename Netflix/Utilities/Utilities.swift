//
//  Utilities.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 25.6.22.
//

import Foundation

class Utilities {
    static let sharedInstance = Utilities()
    
    func jsonToData(json: Any) -> Data? {
          do {
              return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
          } catch let myJSONError {
              print(myJSONError)
          }
          return nil;

      }
}
