# WanderLog – iOS Travel Journal App  
*A SwiftUI + CoreData + Location Services + WidgetKit project for PROG31975 – Advanced Mobile App Development*

---

## Overview

**WanderLog** is a modern travel journal app built using **SwiftUI**, **CoreData**, **Location Services**, and **WidgetKit**.  
It allows users to save and revisit memories of places they’ve been by recording:

- Title  
- Notes  
- Category  
- Date  
- Rating  
- City / Country (auto-filled via Location Services)  
- Optional images (future improvement)

The UI uses animated cards, scroll transitions, glowing borders, and glass-like components for a polished modern design.

This project fulfills all requirements from the course outline, including an **Advanced iOS Feature: WidgetKit**.

---

## Key Features

### Trip Management
- Add new trips with title, notes, date, rating, and category  
- Auto-fill city and country using Core Location  
- View all trips in a beautiful animated card layout  
- Full detail view for each trip  
- Delete trips  
- Data persists via CoreData

### Custom UI Design
- Animated scroll transitions (scale, blur, opacity)  
- `lucentBorder` glowing border modifier  
- Sticky header showing travel statistics  
- Gradient backgrounds, shadows, and modern SwiftUI styling  

### Location Services
- Request user authorization  
- Retrieve current latitude/longitude  
- Reverse geocode into **City, Country**  
- One-tap autofill inside Add Trip screen  

### Advanced iOS Feature: WidgetKit
A home screen widget called **Trip of the Day**, featuring:

- Title  
- Location  
- Category icon  
- Rating  
- Gradient background  
- Updates hourly  

This satisfies the “Advanced iOS Functionality” requirement.

---

## Architecture

Project follows an **MVVM + Services** approach:

WanderLog/
│
├── Models/
│ ├── Trip.swift
│ ├── TripCategory.swift
│
├── Persistence/
│ ├── TripEntity (CoreData)
│ ├── PersistenceController.swift
│
├── ViewModels/
│ ├── TripStore.swift
│ ├── LocationManager.swift
│
├── Views/
│ ├── HomeView.swift
│ ├── TripsView.swift
│ ├── TripDetailView.swift
│ ├── AddTripView.swift
│ ├── CardTripView.swift
│ ├── Shared/
│ ├── LucentBorder.swift
│
├── WanderLogWidgetExtension/
│ ├── WanderLogWidget.swift
│ ├── WanderLogWidgetBundle.swift (optional)
│
└── WanderLogApp.swift

## CoreData Model

The `TripEntity` CoreData structure:

| Field        | Type    |
|--------------|---------|
| id           | UUID    |
| title        | String  |
| notes        | String  |
| dateVisited  | Date    |
| category     | String  |
| rating       | Int16   |
| city         | String  |
| country      | String  |
| latitude     | Double  |
| longitude    | Double  |

---

## Screenshots
TODO

### Home Screen  
Animated card layout with scroll transitions.

### Trips Screen  
Sticky header showing stats + trip list.

### Add Trip  
Form for entering trip details with “Use My Location”.

### Trip Detail  
Full details including rating, date, location, and notes.

### Widget  
Trip of the Day widget.


### Requirements
- Xcode 15+  
- iOS 17+  
- Swift 5.9  
- Compatible with iPhone 15 simulator  

### Steps
1. Clone the project:
   ```bash
   git clone https://github.com/your-username/WanderLog.git
