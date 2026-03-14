# Stocks

A real-time stock tracking iOS application with watchlist management, interactive charts, and financial news integration.

`MVC` | `Protocol-Oriented` | `Programmatic UI`

<!-- Screenshots: Add 2-3 app screenshots here -->

## Features

- **Watchlist** -- Track stocks with live price data and mini sparkline charts; add, remove, and reorder symbols
- **Search** -- Debounced real-time symbol search powered by Finnhub API
- **Stock Details** -- Interactive line charts (7-day price history), key financial metrics (52-week range, beta, volume), and company-specific news
- **News Feed** -- Top market stories and per-company news displayed in a floating drawer panel, opening full articles in Safari
- **Haptic Feedback** -- Contextual haptic responses on user interactions

## Tech Stack & Architecture

| Layer         | Technology                           |
| ------------- | ------------------------------------ |
| Language      | Swift 5                              |
| UI Framework  | UIKit (programmatic, no Storyboards) |
| Networking    | URLSession with Codable              |
| Persistence   | UserDefaults                         |
| Charts        | DGCharts                             |
| Image Loading | SDWebImage                           |
| UI Components | FloatingPanel                        |
| Dependencies  | CocoaPods                            |

The project follows **MVC** with lightweight, cell-scoped ViewModels for formatted data presentation. MVC was chosen to keep the layer boundaries explicit while avoiding abstraction overhead -- each controller owns a clear slice of the screen, and nested ViewModel structs handle display formatting without introducing a separate binding layer.

## Technical Highlights

**Concurrent Data Loading** -- `DispatchGroup` coordinates parallel API calls (market data, metrics, and news) on the stock detail screen, ensuring the UI updates only after all responses arrive.

**Memory-Safe Async Chains** -- Every completion handler captures `[weak self]` with guard-let unwrapping, and `defer { group.leave() }` blocks guarantee dispatch group balance even on early returns.

**Debounced Search** -- A 0.3-second `Timer` invalidation strategy prevents redundant API calls during rapid typing, reducing network overhead without sacrificing responsiveness.

**Protocol-Driven Communication** -- Custom delegate protocols (`SearchResultsViewControllerDelegate`, `WatchListTableViewCellDelegate`, `NewsHeaderViewDelegate`) decouple view controllers from their child views, making each component independently testable and reusable.

## Project Structure

```
Stocks/
├── Controllers/
│   ├── WatchListViewController.swift
│   ├── StockDetailsViewController.swift
│   ├── SearchResultsViewController.swift
│   └── NewsViewController.swift
├── Views/
│   ├── WatchListTableViewCell.swift
│   ├── StockChartView.swift
│   ├── StockDetailHeaderView.swift
│   ├── NewsStoryTableViewCell.swift
│   ├── NewsHeaderView.swift
│   ├── MetricCollectionViewCell.swift
│   └── SearchResultTableViewCell.swift
├── Models/
│   ├── SearchResponse.swift
│   ├── NewsStory.swift
│   ├── MarketDataResponse.swift
│   └── FinancialMetricsResponse.swift
├── Managers/
│   ├── APICaller.swift
│   ├── PersistenceManager.swift
│   └── HapticsManager.swift
└── Other/
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    └── Extensions.swift
```

## Getting Started

**Prerequisites:** Xcode 14+, CocoaPods

```bash
git clone https://github.com/AnilBurcu/Stocks.git
cd Stocks
pod install
open Stocks.xcworkspace
```

The app uses the [Finnhub API](https://finnhub.io/) for market data. The API key is bundled in the source -- replace it in `APICaller.swift` if you need your own quota.

Build and run on a simulator or device (iOS 15+).
