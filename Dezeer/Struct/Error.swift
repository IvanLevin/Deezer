//
//  Error.swift
//  Dezeer
//
//  Created by Levin Ivan on 11.07.2020.
//  Copyright © 2020 Levin Ivan. All rights reserved.
//

import UIKit

struct AppError: Error {
    var title: String?
    var message: String
    
    init(title: String? = nil, message: String) {
        self.title = title
        self.message = message
    }
}

enum ErrorShowing {
    struct Request {
        var errorDesc: String
    }
    struct Response {
        var errorDesc: String
    }
    struct ViewModel {
        var error: AppError
    }
}

enum MessageShowing {
    struct Request {
        var text: String
    }
    struct Response {
        var text: String
    }
    struct ViewModel {
        var text: String
    }
}
