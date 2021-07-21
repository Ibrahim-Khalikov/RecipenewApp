//
//  TabViews.swift
//  Recipe List App
//
//  Created by cloud_vfx on 21/07/21.
//

import SwiftUI

struct TabViews: View {
    var body: some View {
        
        
        TabView{
          
            FeaturedView()
                
                .tabItem {
                    VStack{
                        Image(systemName: "arrow.left.and.right.square")
                        Text("Tab 1")
                    }
                }
            
            RecipeListView()
            
                .tabItem {
                    VStack(){
                        Image(systemName: "list.bullet")
                        Text("Tab 2")
                    }
                }
            
        }.environmentObject(RecipeModel())
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
