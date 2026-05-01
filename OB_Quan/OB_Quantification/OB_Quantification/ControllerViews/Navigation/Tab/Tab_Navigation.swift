//
//  Tab_Navigation.swift
//  OB_Quantification
//
//  Created by Arison on 11/5/25.
//

import SwiftUI

// MARK: - Main Tab Navigation
struct Tab_Nav: View {
    @State private var selectedTab: UUID = TabItem.tabs.first!.id
    @ObservedObject var navBarModel: NavBarModel
    var body: some View {
        VStack(spacing: 0) {
            // --- Main content area ---
            TabView(selection: $selectedTab) {
                ForEach(TabItem.tabs) { tab in
                    SplitColumn(tab: tab, navBarModel: navBarModel)
                        .tag(tab.id)   // tag must match selectedTab type (UUID)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: selectedTab) { _, newValue in
                if let activeTab = TabItem.tabs.first(where: { $0.id == newValue }) {
                    navBarModel.update(with: activeTab)
                }
            }

            // --- Scrollable bottom bar ---
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(TabItem.tabs) { tab in
                        Button {
                            withAnimation(.easeInOut) {
                                selectedTab = tab.id
                            }
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: tab.systemImage)
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedTab == tab.id ? .accentColor : .gray)
                                Text(tab.title)
                                    .font(.caption)
                                    .foregroundColor(selectedTab == tab.id ? .accentColor : .gray)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedTab == tab.id ? Color(.systemGray6) : Color.clear)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .background(Color(.systemBackground).shadow(radius: 1))
        }
    }
}

#Preview {
    Tab_Nav(
        navBarModel: NavBarModel())
}
