//
//  String.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation
import SwiftBase32
import CryptoSwift

extension String {
    
    func codeArray() -> [String] {
        var arr = ["","","","","",""]
        for (key, value) in self.enumerated() {
            arr[key] = String(value)
        }
        return arr
    }
    
    func generateCode() -> String {
        guard let key = base32Decode(self.replacingOccurrences(of: " ", with: "")) else { return "" }
        
        let intervalTime = 30
        let date = Date.now
        let unixTime: TimeInterval = date.timeIntervalSince1970
        let unixTimeInt = Int(unixTime)
        let timeSteps = unixTimeInt / intervalTime
        
        let counter = withUnsafeBytes(of: timeSteps.bigEndian, Array.init)
        
        let hash = try! HMAC(key: key, variant: .sha1).authenticate(counter)
        
        let offset = Int(hash.last! & 0b00001111)
        
        var slicedHash = Array(hash[offset...offset+3])
        
        slicedHash[0] = slicedHash[0] & 0b01111111
        
        let num = Data(slicedHash).withUnsafeBytes { $0.load(as: UInt32.self).bigEndian }
        
        let top = String(num).suffix(6)
        
        return String(top)
    }
    
    func getKey() -> (String, String, String) {
        let url = URL(string: self)!
        
        var path = url.path
        path.removeFirst()
        
        let issuer = path.split(separator: ":")[0]
        let name = path.split(separator: ":")[1]
        
        print(url.scheme)
        print(url.query)
        
        let key = (url.query?.split(separator: "&")[0].split(separator: "=")[1])!
        
        return (String(issuer), String(name), String(key))
    }
    
}
