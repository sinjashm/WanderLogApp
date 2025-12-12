//
//  HomeView.swift
//  WanderLogApp
//
//  Created by Jashman Singh on 11/12/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tripStore: TripStore
    @State private var selectedTrip: Trip?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(tripStore.trips) { trip in
                        card(for: trip)
                            .onTapGesture {
                                withAnimation(.spring) {
                                    selectedTrip = trip
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("WanderLog")
            .toolbar {
                NavigationLink {
                    AddTripView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .sheet(item: $selectedTrip) { trip in
                TripDetailView(trip: trip)
            }
        }
    }

    @ViewBuilder
    func card(for trip: Trip) -> some View {
        CardTripView(trip: trip)
            .frame(height: 200)
            .scrollTransition { content, phase in
                content
                    .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                    .blur(radius: phase.isIdentity ? 0 : 8)
                    .opacity(phase.isIdentity ? 1 : 0)
                    .offset(y: phase.isIdentity ? 0 : 40)
            }
    }
}

struct CardTripView: View {
    let trip: Trip

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                Image(systemName: trip.category.icon)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.06)
                    .padding(40)
            )

            LinearGradient(
                colors: [.clear, .black.opacity(0.7)],
                startPoint: .center,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 6) {
                Text(trip.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)

                Text(trip.locationSummary)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                HStack(spacing: 4) {
                    ForEach(0..<trip.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .lucentBorder(radius: 20)
        .shadow(color: .black.opacity(0.3), radius: 10, y: 8)
    }
}
    
