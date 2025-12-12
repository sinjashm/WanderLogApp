//
//  TripStore.swift
//  WanderLogApp
//
//  Created by Jashman Singh  991676480 on 11/12/25.
//
import Foundation
import SwiftUI
import CoreData
import CoreLocation

@MainActor
class TripStore: ObservableObject {
    @Published var trips: [Trip] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchTrips()
        if trips.isEmpty {
            seedSampleTrips()
        }
    }

    // MARK: - Fetch

    func fetchTrips() {
        let request: NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "dateVisited", ascending: false)
        ]

        do {
            let entities = try context.fetch(request)
            self.trips = entities.map(Trip.init(entity:))
        } catch {
            print("Failed to fetch trips: \(error.localizedDescription)")
        }
    }

    // MARK: - Add

    func add(_ trip: Trip) {
        let entity = TripEntity(context: context)
        entity.id = trip.id
        entity.title = trip.title
        entity.notes = trip.notes
        entity.dateVisited = trip.dateVisited
        entity.category = trip.category.rawValue
        entity.rating = Int16(trip.rating)
        entity.city = trip.city
        entity.country = trip.country

        if let coord = trip.coordinate {
            entity.latitude = coord.latitude
            entity.longitude = coord.longitude
        } else {
            entity.latitude = 0
            entity.longitude = 0
        }

        save()
        fetchTrips()
    }

    // MARK: - Update

    func update(_ trip: Trip) {
        let request: NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", trip.id as CVarArg)
        request.fetchLimit = 1

        do {
            if let entity = try context.fetch(request).first {
                entity.title = trip.title
                entity.notes = trip.notes
                entity.dateVisited = trip.dateVisited
                entity.category = trip.category.rawValue
                entity.rating = Int16(trip.rating)
                entity.city = trip.city
                entity.country = trip.country

                if let coord = trip.coordinate {
                    entity.latitude = coord.latitude
                    entity.longitude = coord.longitude
                } else {
                    entity.latitude = 0
                    entity.longitude = 0
                }

                save()
                fetchTrips()
            }
        } catch {
            print("Failed to update trip: \(error.localizedDescription)")
        }
    }

    // MARK: - Delete

    func delete(_ trip: Trip) {
        let request: NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", trip.id as CVarArg)
        request.fetchLimit = 1

        do {
            if let entity = try context.fetch(request).first {
                context.delete(entity)
                save()
                fetchTrips()
            }
        } catch {
            print("Failed to delete trip: \(error.localizedDescription)")
        }
    }

    // MARK: - Stats

    var totalTrips: Int { trips.count }

    var uniqueCountriesCount: Int {
        Set(trips.map { $0.country }.filter { !$0.isEmpty }).count
    }

    // MARK: - Private

    private func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Core Data save error: \(error.localizedDescription)")
        }
    }

    private func seedSampleTrips() {
        let sampleTrips: [Trip] = [
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

        for trip in sampleTrips {
            add(trip)
        }
    }
}

