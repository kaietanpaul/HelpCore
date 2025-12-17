# HelpCore

SwiftUI charity companion that lets people browse cases, watch sponsor-funded ads to help, and track impact with leaderboards and a personal profile.

## Highlights
- Curated dashboard with promoted causes, progress, and quick navigation.
- Floating center "Watch" action that funds a selected case via an ad view.
- Search across cases, tags, and locations.
- Case detail pages with impact metrics and focus tags.
- Leaderboard and profile screens for stats, streaks, and favorites.

## Project layout
- HelpCoreApp/App: Entry point (`HelpCoreApp`) bootstraps the shared data store.
- HelpCoreApp/Models: Core models for cases, profile, leaderboard.
- HelpCoreApp/Services: Observable data store with mock data and ad-watch updates.
- HelpCoreApp/ViewModels: Screen-specific state for dashboard, detail, search, profile, leaderboard.
- HelpCoreApp/Views: SwiftUI screens and UI components (custom tab bar, cards, tags).

## Running
1) Open the folder in Xcode (iOS 17+ target, Swift 5.9+).
2) Select an iOS Simulator and run. No additional setup or secrets required.

## Notes
- Data is mocked for now; replace `CharityDataStore` with real networking when ready.
- Ad watch currently increments impact and funding locally; wire this to your ad/network stack for production.
