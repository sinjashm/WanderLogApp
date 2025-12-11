//
//  TripStore.swift
//  WanderLogApp
//
//  Created by Jashman Singh on 11/12/25.
//

import Foundation
import SwiftUI
import CoreLocation

@MainActor
class TripStore: ObservableObject {
    @Published var trips: [Trip] = []

    init() {
        trips = [
            Trip(title: "Sunset at the Lake",
                 notes: "Beautiful golden hour. Quiet and peaceful.",
                 dateVisited: Date().addingTimeInterval(-86400 * 3),
                 category: .nature,
                 rating: 5,
                 city: "Burlington",
                 country: "Canada"),
            Trip(title: "Downtown Toronto Night Walk",
                 notes: "City lights and street food.",
                 dateVisited: Date().addingTimeInterval(-86400 * 10),
                 category: .city,
                 rating: 4,
                 city: "Toronto",
                 country: "Canada"),
            Trip(title: "Sushi with Friends",
                 notes: "Tried a new place, really good.",
                 dateVisited: Date().addingTimeInterval(-86400 * 1),
                 category: .food,
                 rating: 5,
                 city: "Mississauga",
                 country: "Canada")
        ]
    }

    func add(_ trip: Trip) {
        trips.insert(trip, at: 0)
    }

    func update(_ trip: Trip) {
        if let index = trips.firstIndex(where: { $0.id == trip.id }) {
            trips[index] = trip
        }
    }

    func delete(_ trip: Trip) {
        trips.removeAll { $0.id == trip.id }
    }

    var totalTrips: Int { trips.count }

    var uniqueCountriesCount: Int {
        Set(trips.map { $0.country }.filter { !$0.isEmpty }).count
    }
}
