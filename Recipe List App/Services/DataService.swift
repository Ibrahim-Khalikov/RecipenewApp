//
//  DataService.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-01-14.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        // Parse local json file
        
        // Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Recipe]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // Add the unique IDs
                for r in recipeData {
                    r.id = UUID()
                    
                    for i in r.ingredients{
                        i.id = UUID()
                    }
                }
                
                // Return the recipes
                return recipeData
            }
            catch {
                // error with parsing json
                print(error)
            }
        }
        catch {
            // error with getting data
            print(error)
        }
        
        return [Recipe]()
    }
    
    static func getPortion(ingredients:Ingredient, recipeServing: Int, targerServing: Int) -> String {
        
        var portion = ""
        var numerator = ingredients.num ?? 1
        var denominator = ingredients.denom ?? 1
        var wholeportion = 0
        
        if numerator != nil {
            
            denominator *= recipeServing
            numerator *= targerServing
            
            
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            
            numerator /= divisor
            denominator /= divisor
            
            if numerator >= denominator {
                
                wholeportion = numerator / denominator
                numerator = numerator % denominator
                portion += String(wholeportion)
             }
            
            if numerator > 0 {
                
                portion += wholeportion > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
                
                
            }
        }
        
        if var unit = ingredients.unit {
            
            if wholeportion > 1 {
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else{
                    unit += "s"
                }
            }
            
            portion += ingredients.num == nil && ingredients.denom == nil ? "" : " "
                
                return portion + unit
        }
        
        return portion
    }
}
