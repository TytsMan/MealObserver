//
//  Result+Ext.swift
//
//
//  Created by divan on 9/15/24.
//

import Foundation

extension Result {
 
    var success: Success? {
        switch self {
        case .success(let success):
            success
        case .failure:
            nil
        }
    }
    
    var failure: Failure? {
        switch self {
        case .success:
            nil
        case .failure(let failure):
            failure
        }
    }
    
}
