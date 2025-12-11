import WidgetKit
import SwiftUI

// MARK: - Entry

struct TripWidgetEntry: TimelineEntry {
    let date: Date
    let title: String
    let location: String
    let categoryIcon: String
    let rating: Int
}

// MARK: - Timeline Provider

struct TripWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> TripWidgetEntry {
        TripWidgetEntry(
            date: Date(),
            title: "Sample Trip",
            location: "Toronto, Canada",
            categoryIcon: "building.2.fill",
            rating: 4
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (TripWidgetEntry) -> ()) {
        let entry = placeholder(in: context)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TripWidgetEntry>) -> ()) {
        // For now, just show one entry and refresh in an hour
        let currentDate = Date()

        // You can randomize this later or pull from shared data
        let sampleTrips: [TripWidgetEntry] = [
            TripWidgetEntry(
                date: currentDate,
                title: "Sunset at the Lake",
                location: "Burlington, Canada",
                categoryIcon: "leaf.fill",
                rating: 5
            ),
            TripWidgetEntry(
                date: currentDate,
                title: "Night Walk",
                location: "Toronto, Canada",
                categoryIcon: "building.2.fill",
                rating: 4
            ),
            TripWidgetEntry(
                date: currentDate,
                title: "Sushi with Friends",
                location: "Mississauga, Canada",
                categoryIcon: "fork.knife",
                rating: 5
            )
        ]

        let chosen = sampleTrips.randomElement() ?? sampleTrips[0]

        let entryDate = currentDate
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!

        let entry = TripWidgetEntry(
            date: entryDate,
            title: chosen.title,
            location: chosen.location,
            categoryIcon: chosen.categoryIcon,
            rating: chosen.rating
        )

        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}

// MARK: - Widget View

struct TripWidgetView: View {
    var entry: TripWidgetEntry

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            LinearGradient(
                colors: [.clear, .black.opacity(0.7)],
                startPoint: .center,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: entry.categoryIcon)
                        .font(.title2)
                    Text("Trip of the Day")
                        .font(.caption)
                        .textCase(.uppercase)
                        .opacity(0.8)
                }

                Text(entry.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(entry.location)
                    .font(.caption)
                    .opacity(0.8)
                    .lineLimit(1)

                HStack(spacing: 3) {
                    ForEach(0..<entry.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .font(.caption2)
                    }
                }
                .foregroundStyle(.yellow)
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}

// MARK: - Widget Definition

@main
struct WanderLogWidget: Widget {
    let kind: String = "WanderLogWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TripWidgetProvider()) { entry in
            TripWidgetView(entry: entry)
        }
        .configurationDisplayName("Trip of the Day")
        .description("Shows a featured trip from WanderLog.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview

struct WanderLogWidget_Previews: PreviewProvider {
    static var previews: some View {
        TripWidgetView(
            entry: TripWidgetEntry(
                date: Date(),
                title: "Sunset at the Lake",
                location: "Burlington, Canada",
                categoryIcon: "leaf.fill",
                rating: 5
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
