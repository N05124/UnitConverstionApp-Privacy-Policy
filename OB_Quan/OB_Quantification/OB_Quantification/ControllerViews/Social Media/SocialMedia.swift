//
//  SocialMedia.swift
//  OB_Quantification
//
//  Created by Arison on 11/17/25.
//

import Foundation
import SwiftUI
struct SocialMedia: View{
 
    var body: some View {
        NavigationView(){
            VStack{
                HStack{
            
                    Spacer()
                    Text("Support")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)
                        .frame(alignment: .center)
                    Spacer()
                   
                }
                .frame(maxWidth: .infinity)
                Divider()
                VStack{
                    Spacer()
                    Button {
                        if let url = URL(string: "https://www.instagram.com/threaded_realm/") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        InstagramGradientIcon()
                    }
                    Text("@Threaded_Realms")
                    Spacer()
                    Button {
                        if let url = URL(string: "https://x.com/ThreadedRealms") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        XIcon()
                    }
                    Text("@ThreadedRealms")
                }
                Spacer()
                    .frame(height: .infinity)
            }
        }
    }
   

    struct XIcon: View {
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white) // or Color.white
                    .frame(width: 90, height: 90)

                Image(uiImage: #imageLiteral(resourceName: "logo-black")) // Your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
        }
    }
    
    struct InstagramGradientIcon: View {
        var body: some View {
            ZStack {

                // Background gradient rounded square
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.98, green: 0.65, blue: 0.14), // orange
                                Color(red: 0.94, green: 0.33, blue: 0.41), // pink
                                Color(red: 0.46, green: 0.14, blue: 0.79)  // purple
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)

                // Inner camera shape – clean + simple
                ZStack {
                    // Outer camera border
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.white, lineWidth: 7)
                        .frame(width: 70, height: 70)

                    // Lens
                    Circle()
                        .stroke(Color.white, lineWidth: 7)
                        .frame(width: 28, height: 28)

                    // Small flash dot
                    Circle()
                        .fill(Color.white)
                        .frame(width: 14, height: 14)
                        .offset(x: 22, y: -22)
                }
            }
        }
    }

}

#Preview{
    SocialMedia()
}
