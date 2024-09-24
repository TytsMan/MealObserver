//
//  Result+map.swift
//  MealObserver
//
//  Created by divan on 9/23/24.
//

import Foundation

extension Result {
    var value: Success? {
        guard case let .success(value) = self else {
            return nil
        }
        return value
    }
    
    var error: Failure? {
        guard case let .failure(error) = self else {
            return nil
        }
        return error
    }
}
