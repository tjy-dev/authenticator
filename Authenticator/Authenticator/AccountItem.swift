//
//  AccountItem.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation

struct CodeItem {
    var id: Int
    var key: String
    var title: String
    var desc: String?
    
    init(id: Int, key: String, title: String, desc: String?) {
        self.id = id
        self.key = key
        self.title = title
        self.desc = desc
    }
    
    init() {
        id = 0
        key = ""
        title = ""
        desc = ""
    }
}
