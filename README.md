# Daraz-style Product Listing Assignment

## Running the Application
1. Ensure Flutter is installed.
2. Clone the repository.
3. Run `flutter pub get`.
4. Run `flutter run`.

### Credentials
- **Username**: `mor_2314`
- **Password**: `83r5^_`

---

## Technical Explanation (Updated for Independent Scrolling)

### 1. How horizontal swipe was implemented
The horizontal swipe is now implemented using the native `TabBarView`. 
- `TabBarView` provides smooth horizontal sliding animations that follow the user's finger.
- It is coordinated with the `TabController` shared by the `TabBar` in the header.
- This provides a more "premium" feel than a discrete binary swipe detection.

### 2. Who owns the vertical scroll and why
Vertical scroll ownership is split using `NestedScrollView`:
- **Outer Scrollable**: Owns the collapsible header (banner and TabBar). It ensures the header collapses as the user scrolls up in *any* tab.
- **Inner Scrollables**: Each tab has its own `CustomScrollView`. 
- **Why?** This architecture allows each tab to maintain its own independent scroll position (e.g., Tab A is at the bottom, Tab B is at the top) while still sharing a single collapsible header. 
- Using `SliverOverlapAbsorber` and `SliverOverlapInjector` ensures that the inner lists don't hide behind the sticky TabBar.

### 3. Trade-offs or limitations of your approach
- **Trade-off (Complexity)**: `NestedScrollView` is more complex to implement than a single `CustomScrollView`. It requires careful handling of layout overlaps.
- **Trade-off (Performance)**: Maintaining multiple scroll positions consumes slightly more memory, but it's negligible for few tabs.
- **Limitation**: The "pinning" behavior of `NestedScrollView` can sometimes be tricky with certain configurations, but using the standard Absorber/Injector pattern resolves most jitter.

---

## Architecture
- **State Management**: GetX for simple and reactive state handling.
- **Services**: `ApiService` for FakeStore API integration.
- **UI**: Sliver-based layout for smooth collapsible headers and sticky components.
