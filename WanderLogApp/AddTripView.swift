//
//  AddTripView.swift
//  WanderLogApp
//
//  Created by Jashman Singh  991676480 on 11/12/25.
//

import SwiftUI

struct AddTripView: View {
    @EnvironmentObject var tripStore: TripStore
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var notes = ""
    @State private var dateVisited = Date()
    @State private var category: TripCategory = .other
    @State private var rating = 4
    @State private var city = ""
    @State private var country = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Basics") {
                    TextField("Title", text: $title)
                    Picker("Category", selection: $category) {
                        ForEach(TripCategory.allCases) { cat in
                            Label(cat.rawValue, systemImage: cat.icon)
                                .tag(cat)
                        }
                    }
                    Stepper("Rating: \(rating)", value: $rating, in: 1...5)
                    DatePicker("Visited on", selection: $dateVisited, displayedComponents: .date)
                }

                Section("Location") {
                    TextField("City", text: $city)
                    TextField("Country", text: $country)

                    Button {
                        locationManager.requestPermission()
                        locationManager.fetchLocation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            if !locationManager.currentCity.isEmpty {
                                city = locationManager.currentCity
                            }
                            if !locationManager.currentCountry.isEmpty {
                                country = locationManager.currentCountry
                            }
                        }
                    } label: {
                        Label("Use My Current Location", systemImage: "location.circle")
                    }
                   
                }

                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 120)
                }
            }
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trip = Trip(
                            title: title.isEmpty ? "Untitled Trip" : title,
                            notes: notes,
                            dateVisited: dateVisited,
                            category: category,
                            rating: rating,
                            city: city,
                            country: country,
                            coordinate: locationManager.currentLocation?.coordinate,
                            image: nil
                        )
                        tripStore.add(trip)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

