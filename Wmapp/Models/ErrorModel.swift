//
//  ErrorModel.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

class ErrorModel: BaseModel, Error {
    
    var errorCode: Int?
    var errorMessage: String?
    
    init(errorCode: Int?, errorMessage: String?) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
    
}
