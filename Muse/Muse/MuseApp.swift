//
//  MuseApp.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

@main
struct MuseApp: App {
    var body: some Scene {
        WindowGroup {
            MakeTicketView(searchText: "", comment: "")
        }
    }
}
