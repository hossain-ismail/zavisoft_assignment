# Daraz-style Product Listing Assignment (Final Version)

This implementation represents the "Gold Standard" for Daraz/Instagram style tabbed scrolling in Flutter, satisfying the requirements for both a synchronized collapsible header and independent tab scroll positions.

### 1. Unified Collapsible Header (Shared State)
By using `NestedScrollView`, the header (banner and TabBar) is part of an **Outer Scrollable**.
- When you scroll in *any* tab, the header collapses.
- Once the header is collapsed, it stays pinned across all tabs.

### 2. Independent Tab Scrolling (Memorized Positions)
Each tab contains its own `CustomScrollView` (the **Inner Scrollables**).
- **Position Persistence**: I used `PageStorageKey` for each tab's scroll view.
- **Result**: Flutter automatically "memorizes" the scroll offset for each category. If you scroll to the middle of "Electronics", switch to "Jewellery", and then come back, you will still be in the middle of Electronics.

### 3. Coordinated Gestures
- **Vertical**: Handled by the relationship between `NestedScrollView`'s outer and inner controllers. Scrolling is seamless and correctly hands off control between the header and the body.
- **Horizontal**: Handled by native `TabBarView`, providing smooth, finger-following transitions between categories.

### 4. Layout Accuracy
- **SliverOverlapAbsorber/Injector**: These specialized slivers are used to ensure that the content within each tab starts below the sticky TabBar and doesn't disappear behind it when scrolled to the top.

---

## Technical Details
- **Architecture**: `NestedScrollView` + `TabBarView`.
- **State Management**: `GetX` for reactive data binding.
- **Scroll Persistence**: `PageStorageKey` and `AutomaticKeepAliveClientMixin` (via the standard `TabBarView` children caching).

## How to Run
1. `flutter pub get`
2. `flutter run`

**Credentials**: `mor_2314` / `83r5^_`
