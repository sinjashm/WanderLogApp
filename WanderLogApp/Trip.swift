//
//  Trip.swift
//  WanderLogApp
//
//  Created by Jashman Singh on 11/12/25.
//

import Foundation
import CoreLocation
import SwiftUI

enum TripCategory: String, CaseIterable, Identifiable {
    case nature = "Nature"
    case city = "City"
    case food = "Food"
    case adventure = "Adventure"
    case other = "Other"

    var id: String { rawValue }
    var icon: String {
        switch self {
        case .nature: return "leaf.fill"
        case .city: return "building.2.fill"
        case .food: return "fork.knife"
        case .adventure: return "figure.hiking"
        case .other: return "globe.asia.australia.fill"
        }
    }
}

struct Trip: Identifiable {
        
    let id: UUID
    var title: String
    var notes: String
    var dateVisited: Date
    var category: TripCategory
    var rating: Int
    var city: String
    var country: String
    var coordinate: CLLocationCoordinate2D?
    var image: UIImage?

    init(id: UUID = UUID(),
         title: String,
         notes: String = "",
         dateVisited: Date = .now,
         category: TripCategory = .other,
         rating: Int = 4,
         city: String = "",
         country: String = "",
         coordinate: CLLocationCoordinate2D? = nil,
         image: UIImage? = nil) {
        self.id = id
        self.title = title
        self.notes = notes
        self.dateVisited = dateVisited
        self.category = category
        self.rating = rating
        self.city = city
        self.country = country
        self.coordinate = coordinate
        self.image = image
    }

    var locationSummary: String {
        if city.isEmpty && country.isEmpty { return "Unknown Location" }
        if city.isEmpty { return country }
        if country.isEmpty { return city }
        return "\(city), \(country)"
    }
}

extension Trip {
    init(entity: TripEntity) {
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? "Untitled Trip"
        self.notes = entity.notes ?? ""
        self.dateVisited = entity.dateVisited ?? Date()
        let rawCat = entity.category ?? TripCategory.other.rawValue
        self.category = TripCategory(rawValue: rawCat) ?? .other
        self.rating = Int(entity.rating)
        self.city = entity.city ?? ""
        self.country = entity.country ?? ""

        if entity.latitude != 0 || entity.longitude != 0 {
            self.coordinate = CLLocationCoordinate2D(
                latitude: entity.latitude,
                longitude: entity.longitude
            )
        } else {
            self.coordinate = nil
        }

        self.image = nil 
    }
}
