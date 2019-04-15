//
//  Enum.swift
//  santander-test-clean-swift
//
//  Created by Cesar Giupponi Paiva on 12/04/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation

enum Regex: String {
    case email = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    case password = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{4,}"
}

enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
