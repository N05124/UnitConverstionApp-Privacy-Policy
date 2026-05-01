//
//  NavigationBarView.swift
//  OB_Quantification
//
//  Created by Arison on 11/5/25.
//


import Foundation
import SwiftUI

struct NavigationBar: View {
    @ObservedObject var model: NavBarModel
    var body: some View {
            VStack(spacing: 4) {
                // --- Top Row ---
                HStack {
                    Text(model.currentPage)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(model.appTitle ?? "")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    // Right side placeholder to balance layout
                    Text("")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                // --- Bottom Row ---
                HStack {
                    Text(model.status)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(model.appVersion ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    NavigationLink(destination: SocialMedia()) {
                        Text("Support")
                            .font(.headline)
                            
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    .padding(.bottom, 2)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
            }
            .padding(.horizontal)
            .background(Color(.systemBackground))
            .overlay(Divider(), alignment: .bottom)
    }
}

#Preview {
    NavigationBar(
        model: NavBarModel()
    )
}
