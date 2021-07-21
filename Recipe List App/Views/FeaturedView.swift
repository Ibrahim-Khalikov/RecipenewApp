//
//  FeaturedView.swift
//  Recipe List App
//
//  Created by cloud_vfx on 21/07/21.
//

import SwiftUI

struct FeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailshowing = false
    @State var tabSelectionIndex = 0
   
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Featured Recipe")
                .bold()
                .font(Font.custom("Avenir Heavy", size: 27))
                .padding([.top, .leading])
            
            VStack(alignment: .leading, spacing: 0){
                
                GeometryReader { geo in
                    
                    TabView(selection: $tabSelectionIndex){
                        
                        ForEach(0..<model.recipes.count){ index in
                        
                         
                            
                            Button(action: {
                                
                                self.isDetailshowing = true
                                
                            }, label: {
                                ZStack{
                                    
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    VStack{
                                        
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .scaledToFill()
                                        
                                        Text(model.recipes[index].name)
                                            .padding(.bottom, 5)
                                            .font(Font.custom("Avenir Heavy", size: 16))                                    }
                                }
                            }).tag(index)
                            .sheet(isPresented: $isDetailshowing) {
                                RecipeDetailView(recipe: model.recipes[index])
                            }
                            .foregroundColor(.black)
                           .frame(width: geo.size.width/1.15, height: geo.size.height/1.2)
                            .cornerRadius(15)
                            .shadow(color:Color(.sRGB , red: 0 , green: 0, blue: 0 , opacity: 0.5),radius: 10 ,x: -5 ,y: 5)
                            
                        
                    }
                        
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    
                }
                
                VStack(alignment: .leading, spacing: 8){
                    
                    Text("Preptime")
                        .font(Font.custom("Avenir Heavy", size: 16))
                    Text(model.recipes[tabSelectionIndex].prepTime)
                        .font(Font.custom("Avenir", size: 15))
                    
                    Text("Highlights")
                        .font(Font.custom("Avenir Heavy", size: 15))
                    
                    highlights(highlights: model.recipes[tabSelectionIndex].highlights )
                        .font(Font.custom("Avenir", size: 15))
                    
                }.padding()
                
            }
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
        
    }
    
    
    func setFeaturedIndex() {
        let index = model.recipes.firstIndex{ (recipe) -> Bool in
            return recipe.featured
        }
        tabSelectionIndex  = index ?? 0
    }
    
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
            .environmentObject(RecipeModel())
    }
}
