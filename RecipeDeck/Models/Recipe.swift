//
//  Recipe.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/16/24.
//

import Foundation

struct Recipe{
    var name: String
    var ingredients: [Ingredient]
    var steps: [Step]
    var image : String
    var time: String
    var suthor: String
    
}
struct Ingredient{
    var item: String
    var amount: String
    var measurement: String

}

struct Step{
    var step : String
    var ingredientsUsed: [Ingredient]
    var image: String
}

