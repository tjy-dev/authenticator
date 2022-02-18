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
            // sample key = HEEOJL4Z2SCMMMJRDG44RH55LNWYDXPM
        guard let key = base32Decode(self) else { return "" }
        
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
    
}
