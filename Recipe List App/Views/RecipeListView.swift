//
//  ContentView.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-01-14.
//

import SwiftUI

struct RecipeListView: View {
    
    // Reference the view model
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                LazyVStack(alignment: .leading){
                
                ForEach(model.recipes) { r in
                
                NavigationLink(
                    destination: RecipeDetailView(recipe:r),
                    label: {
                        
                        // MARK: Row item
                        HStack(spacing: 20.0) {
                            Image(r.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipped()
                                .clipShape(Circle())
                            //.cornerRadius(5)
                         
                            VStack(alignment: .leading){
                            
                            Text(r.name)
                                .font(Font.custom("Avenir Heavy", size: 16))
                                highlights(highlights: r.highlights)
                                    .font(Font.custom("Avenir", size: 13))
                                    .foregroundColor(.gray)
                            }
                        }
                    })
                
                
                
            }
                }.foregroundColor(.black)
                .padding()
                
        }.navigationBarTitle("All Recipes")
            
        }
}
}
struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
