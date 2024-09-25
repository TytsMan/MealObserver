//
//  String+localization.swift
//  MealObserver
//
//  Created by divan on 9/17/24.
//

import Foundation

extension String {
    var localized: Self {
        environment.dependencies.localizer.localize(string: self)
    }
}
