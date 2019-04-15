//
//  Error.swift
//  santander-test-clean-swift
//
//  Created by Cesar Giupponi Paiva on 12/04/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation

struct Error: Codable {
    var message: String?
    var code: Int?
}
