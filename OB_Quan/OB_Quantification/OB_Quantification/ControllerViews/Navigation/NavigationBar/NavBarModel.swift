//
//  NavBarModel.swift
//  OB_Quantification
//
//  Created by Arison on 11/7/25.
//

import Foundation
import Combine
import Foundation
import Combine

class NavBarModel: ObservableObject {
    let appTitle: String? = "Converter"
    let appVersion: String? = "v 0.0.5"
    
    @Published var currentPage: String
    @Published var isExportable: Bool
    @Published var status: String
    
    init(tab: TabItem = TabItem.tabs.first!) {
        self.currentPage = tab.currentPage
        self.isExportable = tab.isExportable
        self.status = tab.status
    }
    
    func update(with tab: TabItem) {
        currentPage = tab.currentPage
        isExportable = tab.isExportable
        status = tab.status
    }
}

