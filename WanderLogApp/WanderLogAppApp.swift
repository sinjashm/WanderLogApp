//
//  WanderLogAppApp.swift
//  WanderLogApp
//
//  Created by Jashman Singh on 11/12/25.
//

import SwiftUI

@main
struct WanderLogAppApp: App {
    let persistenceController = PersistenceController.shared

        @StateObject private var tripStore: TripStore
        @StateObject private var locationManager = LocationManager()

        init() {
            let context = persistenceController.container.viewContext
            _tripStore = StateObject(wrappedValue: TripStore(context: context))
        }

        var body: some Scene {
            WindowGroup {
                RootTabView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(tripStore)
                    .environmentObject(locationManager)
            }
        }
    }
