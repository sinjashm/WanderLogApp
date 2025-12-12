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
<img width="456" height="830" alt="Screenshot 2025-12-12 at 13 06 15" src="https://github.com/user-attachments/assets/89a9e769-8f78-436c-9bb9-4ccef57cc868" />

### Trips Screen  
Sticky header showing stats + trip list.
<img width="445" height="825" alt="Screenshot 2025-12-12 at 13 06 44" src="https://github.com/user-attachments/assets/33e3ac39-79b0-43a0-807a-4991e92fbbba" />


### Add Trip  
Form for entering trip details with “Use My Location”.
<img width="496" height="835" alt="Screenshot 2025-12-12 at 13 06 54" src="https://github.com/user-attachments/assets/608a0168-c679-476f-bb2f-eea734a1c615" />

### Trip Detail  
Full details including rating, date, location, and notes.
<img width="398" height="818" alt="Screenshot 2025-12-12 at 13 07 15" src="https://github.com/user-attachments/assets/5896677c-bc23-4113-9e3f-56fc7ad45612" />

### Widget  
Trip of the Day widget.
<img width="494" height="807" alt="Screenshot 2025-12-12 at 13 07 39" src="https://github.com/user-attachments/assets/9e14b65f-acfe-41e4-81d3-5473d66966d5" />


### Requirements
- Xcode 15+  
- iOS 17+  
- Swift 5.9  
- Compatible with iPhone 15 simulator  

### Steps
1. Clone the project:
   ```bash
   git clone https://github.com/your-username/WanderLog.git
   ```

2. Open in Xcode:
   ```bash
      open WanderLog.xcodeproj
   ```

3. Run the app:
```bash
   Scheme → WanderLogApp → iPhone 15 Simulator
   ```

4. To test the widget:
   ```bash
   Scheme → WanderLogWidgetExtension
   ```


Add the widget from the "+" menu on the simulator.
