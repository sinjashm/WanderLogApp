//
//  WanderLogAppApp.swift
//  WanderLogApp
//
//  Created by Jashman Singh on 11/12/25.
//

import SwiftUI

@main
struct WanderLogAppApp: App {
    @StateObject private var tripStore = TripStore()
    @StateObject private var locationManager = LocationManager()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootTabView()
                            .environmentObject(tripStore)
                            .environmentObject(locationManager)

        }
    }
}
