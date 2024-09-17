//
//  Meal.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation

struct Meal: Hashable, Identifiable, Decodable {
    
    typealias ID = String
    
    struct Igredient: Hashable {
        let name: String
        let measure: String
    }
    
    let id: ID
    let name: String
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
    
    enum CodingKeys: CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .idMeal)
        self.name = try container.decode(String.self, forKey: .strMeal)
        self.drinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        self.category = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.area = try container.decodeIfPresent(String.self, forKey: .strArea)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.thumbnailUrl = URL(string: try container.decodeIfPresent(String.self, forKey: .strMealThumb) ?? "")
        self.tags = try container.decodeIfPresent(String.self, forKey: .strTags)
        self.youtubeURL = URL(string: try container.decodeIfPresent(String.self, forKey: .strYoutube) ?? "")
        self.source = URL(string: try container.decodeIfPresent(String.self, forKey: .strSource) ?? "")
        self.imageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        self.creativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        self.dateModified = try container.decodeIfPresent(Date.self, forKey: .dateModified)
        ingredients = [
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient1),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure1)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient2),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure2)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient3),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure3)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient4),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure4)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient5),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure5)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient6),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure6)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient7),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure7)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient8),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure8)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient9),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure9)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient10),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure10)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient11),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure11)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient12),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure12)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient13),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure13)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient14),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure14)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient15),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure15)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient16),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure16)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient17),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure17)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient18),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure18)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient19),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure19)
            ),
            Igredient(
                name: try container.decodeIfPresent(String.self, forKey: .strIngredient20),
                measure: try container.decodeIfPresent(String.self, forKey: .strMeasure20)
            ),
        ].compactMap { $0 }
    }
    
    init(
        id: ID,
        name: String,
        drinkAlternate: String? = nil,
        category: String? = nil,
        area: String? = nil,
        instructions: String? = nil,
        thumbnailUrl: URL? = nil,
        tags: String? = nil,
        youtubeURL: URL? = nil,
        source: URL? = nil,
        imageSource: String? = nil,
        creativeCommonsConfirmed: String? = nil,
        dateModified: Date? = nil,
        ingredients: [Igredient]? = nil
    ) {
        self.id = id
        self.name = name
        self.drinkAlternate = drinkAlternate
        self.category = category
        self.area = area
        self.instructions = instructions
        self.thumbnailUrl = thumbnailUrl
        self.tags = tags
        self.youtubeURL = youtubeURL
        self.source = source
        self.imageSource = imageSource
        self.creativeCommonsConfirmed = creativeCommonsConfirmed
        self.dateModified = dateModified
        self.ingredients = ingredients
    }
}

private extension Meal.Igredient {
    init?(name: String?, measure: String?) {
        guard let name, let measure else { return nil }
        
        self.name = name
        self.measure = measure
    }
}

#if DEBUG
extension Meal {
    
    static var mock1: Self {
        Meal(
            id: "1",
            name: "Strawberry Rhubarb Pie",
            thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/178z5o1585514569.jpg")!
        )
    }
    
    static var mock2: Self {
        Meal(
            id: "2",
            name: "Sugar Pie",
            thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/yrstur1511816601.jpg")!
        )
    }
    
    static var mock3: Self {
        Meal(
            id: "3",
            name: "Summer Pudding",
            thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/rsqwus1511640214.jpg")!
        )
    }
    
    static var mock4: Self {
        Meal(
            id: "4",
            name: "Tarte Tatin",
            thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/ryspuw1511786688.jpg")!
        )
    }
    
    static var mock5: Self {
        Meal(
            id: "52768",
            name: "Apple Frangipan Tart",
            instructions: "Preheat the oven to 200C/180C Fan/Gas 6.\r\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\r\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\r\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\r\nBake for 20-25 minutes until golden-brown and set.\r\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\r\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream.",
            thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")!,
            ingredients: [
                .init(name: "digestive biscuits", measure: "175g/6oz"),
                .init(name: "butter", measure: "75g/3oz"),
                .init(name: "Bramley apples", measure: "200g/7oz"),
                .init(name: "butter, softened", measure: "75g/3oz"),
                .init(name: "caster sugar", measure: "75g/3oz"),
                .init(name: "free-range eggs, beaten", measure: "2"),
                .init(name: "ground almonds", measure: "75g/3oz"),
                .init(name: "almond extract", measure: "1 tsp"),
                .init(name: "flaked almonds", measure: "50g/1¾oz")
            ]
        )
    }
}
#endif
