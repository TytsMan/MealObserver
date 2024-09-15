//
//  Meal.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation

struct Meal: Hashable, Identifiable {
    struct Igredient: Hashable {
        let name: String
        let measure: String
    }
    
    let id: String
    let title: String
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnailUrl: URL?
    let tags: String?
    let youtubeURL: URL?
    let source: URL?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: Date?
    let ingredients: [Igredient]?
}

extension Meal {
    struct DTO: Codable {
        let idMeal: String
        let strMeal: String
        let strDrinkAlternate: String?
        let strCategory: String?
        let strArea: String?
        let strInstructions: String?
        let strMealThumb: String?
        let strTags: String?
        let strYoutube: String?
        let strIngredient1: String?
        let strIngredient2: String?
        let strIngredient3: String?
        let strIngredient4: String?
        let strIngredient5: String?
        let strIngredient6: String?
        let strIngredient7: String?
        let strIngredient8: String?
        let strIngredient9: String?
        let strIngredient10: String?
        let strIngredient11: String?
        let strIngredient12: String?
        let strIngredient13: String?
        let strIngredient14: String?
        let strIngredient15: String?
        let strIngredient16: String?
        let strIngredient17: String?
        let strIngredient18: String?
        let strIngredient19: String?
        let strIngredient20: String?
        let strMeasure1: String?
        let strMeasure2: String?
        let strMeasure3: String?
        let strMeasure4: String?
        let strMeasure5: String?
        let strMeasure6: String?
        let strMeasure7: String?
        let strMeasure8: String?
        let strMeasure9: String?
        let strMeasure10: String?
        let strMeasure11: String?
        let strMeasure12: String?
        let strMeasure13: String?
        let strMeasure14: String?
        let strMeasure15: String?
        let strMeasure16: String?
        let strMeasure17: String?
        let strMeasure18: String?
        let strMeasure19: String?
        let strMeasure20: String?
        let strSource: String?
        let strImageSource: String?
        let strCreativeCommonsConfirmed: String?
        let dateModified: Date?
    }
    
    init(from dto: DTO) {
        id = dto.idMeal
        title = dto.strMeal
        drinkAlternate = dto.strDrinkAlternate
        category = dto.strCategory
        area = dto.strArea
        instructions = dto.strInstructions
        thumbnailUrl = URL(string: dto.strMealThumb ?? "")
        tags = dto.strTags
        youtubeURL = URL(string: dto.strYoutube ?? "")
        source = URL(string: dto.strSource ?? "")
        imageSource = dto.strImageSource
        creativeCommonsConfirmed = dto.strCreativeCommonsConfirmed
        dateModified = dto.dateModified
        ingredients = [
            Igredient(name: dto.strIngredient1, measure: dto.strMeasure1),
            Igredient(name: dto.strIngredient2, measure: dto.strMeasure2),
            Igredient(name: dto.strIngredient3, measure: dto.strMeasure3),
            Igredient(name: dto.strIngredient4, measure: dto.strMeasure4),
            Igredient(name: dto.strIngredient5, measure: dto.strMeasure5),
            Igredient(name: dto.strIngredient6, measure: dto.strMeasure6),
            Igredient(name: dto.strIngredient7, measure: dto.strMeasure7),
            Igredient(name: dto.strIngredient8, measure: dto.strMeasure8),
            Igredient(name: dto.strIngredient9, measure: dto.strMeasure9),
            Igredient(name: dto.strIngredient10, measure: dto.strMeasure10),
            Igredient(name: dto.strIngredient11, measure: dto.strMeasure11),
            Igredient(name: dto.strIngredient12, measure: dto.strMeasure12),
            Igredient(name: dto.strIngredient13, measure: dto.strMeasure13),
            Igredient(name: dto.strIngredient14, measure: dto.strMeasure14),
            Igredient(name: dto.strIngredient15, measure: dto.strMeasure15),
            Igredient(name: dto.strIngredient16, measure: dto.strMeasure16),
            Igredient(name: dto.strIngredient17, measure: dto.strMeasure17),
            Igredient(name: dto.strIngredient18, measure: dto.strMeasure18),
            Igredient(name: dto.strIngredient19, measure: dto.strMeasure19),
            Igredient(name: dto.strIngredient20, measure: dto.strMeasure20)
        ].compactMap { $0 }
    }
}

private extension Meal.Igredient {
    init?(name: String?, measure: String?) {
        guard let name, let measure else { return nil }

        self.name = name
        self.measure = measure
    }
}
