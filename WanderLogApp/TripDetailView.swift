//
//  TripDetailView.swift
//  WanderLogApp
//
//  Created by Jashman Singh  991676480 on 11/12/25.
//

import SwiftUI

struct TripDetailView: View {
    @EnvironmentObject var tripStore: TripStore
    @Environment(\.dismiss) private var dismiss

    @State var trip: Trip
    @State private var isEditing = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    headerCard

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notes")
                            .font(.headline)
                        if trip.notes.isEmpty {
                            Text("No notes added.")
                                .foregroundStyle(.secondary)
                        } else {
                            Text(trip.notes)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .lucentBorder(radius: 16)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle(trip.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        tripStore.delete(trip)
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
    }

    var headerCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(trip.category.rawValue, systemImage: trip.category.icon)
                    .font(.headline)
                Spacer()
                Text(trip.dateVisited, style: .date)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Text(trip.locationSummary)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(spacing: 4) {
                ForEach(0..<trip.rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .lucentBorder(radius: 20)
        .shadow(radius: 8)
    }
}
