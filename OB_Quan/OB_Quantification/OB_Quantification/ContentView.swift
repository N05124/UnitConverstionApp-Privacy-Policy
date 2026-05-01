//
//  ContentView.swift
//  OB_Quantification
//
//  Created by Arison on 11/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = NavBarModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                NavigationBar(model:model)
                Tab_Nav(navBarModel:model)
            }
        }
    }
}

#Preview {
    ContentView(model: NavBarModel())
}
