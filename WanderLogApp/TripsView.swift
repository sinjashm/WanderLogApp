//
//  TripsView.swift
//  WanderLogApp
//
//  Created by Jashman Singh  991676480 on 11/12/25.
//

import SwiftUI

struct TripsView: View {
    @EnvironmentObject var tripStore: TripStore
    @State private var showAddTrip = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    StickyStatsHeader()

                    ForEach(tripStore.trips) { trip in
                        NavigationLink {
                            TripDetailView(trip: trip)
                        } label: {
                            TripRowView(trip: trip)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("My Trips")
            .toolbar {
                Button {
                    showAddTrip = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddTrip) {
                AddTripView()
            }
        }
    }
}

struct StickyStatsHeader: View {
    @EnvironmentObject var tripStore: TripStore

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hey, Explorer 👋")
                .font(.title2.bold())

            Text("You've logged \(tripStore.totalTrips) trips in \(tripStore.uniqueCountriesCount) countries.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .lucentBorder(radius: 20)
        .shadow(radius: 6)
    }
}

struct TripRowView: View {
    let trip: Trip

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.opacity(0.2))
                .frame(width: 52, height: 52)
                .overlay(
                    Image(systemName: trip.category.icon)
                        .font(.title3)
                        .foregroundStyle(.blue)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(trip.title)
                    .font(.headline)
                Text(trip.locationSummary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(trip.dateVisited, style: .date)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("★\(trip.rating)")
                .font(.caption.bold())
                .padding(6)
                .background(Color.yellow.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .lucentBorder(radius: 16)
    }
}
