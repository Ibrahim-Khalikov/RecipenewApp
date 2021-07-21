//
//  highlights.swift
//  Recipe List App
//
//  Created by cloud_vfx on 21/07/21.
//

import SwiftUI

struct highlights: View {
    
    @EnvironmentObject var model:RecipeModel
    
    var allHighlights = ""
    
    init(highlights: [String]){
        
        for index in 0..<highlights.count {
            
            if index == highlights.count - 1 {
                
                allHighlights += highlights[index]
            }
            else {
                allHighlights += highlights[index] + ", "
            }
        }
        
    }
    
    var body: some View {
        
        Text(allHighlights)
        
    }
}

struct highlights_Previews: PreviewProvider {
    static var previews: some View {
        highlights(highlights: [])
    }
}
