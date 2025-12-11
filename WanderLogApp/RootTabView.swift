//
//  RootTabView.swift
//  WanderLogApp
//
//  Created by Jashman Singh on 11/12/25.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            TripsView()
                .tabItem {
                    Label("Trips", systemImage: "airplane.circle.fill")
                }
        }
    }
}
