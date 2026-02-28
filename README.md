# Daraz-style Product Listing Assignment

A Flutter application implementing a product listing screen with a collapsible header, sticky tab bar, and independent tab scrolling.

## Video Demonstration
[Watch Execution Video](https://drive.google.com/file/d/1vlv0RQB2lf_ugKCSYfVLTUHFLp13vE2Y/view?usp=sharing)

## Screenshot
<img width="250" height="561" alt="Screenshot_1772294903" src="https://github.com/user-attachments/assets/1bb509dc-e14b-4986-b585-236df908aeb4" />
<img width="250" height="561" alt="Screenshot_1772294912" src="https://github.com/user-attachments/assets/03e505af-f3e9-4e99-9c64-8cdcfa1ef82c" />
<img width="250" height="561" alt="Screenshot_1772294918" src="https://github.com/user-attachments/assets/ff41bc42-1179-434b-a915-c20f8c884faa" />
<img width="250" height="561" alt="Screenshot_1772294930" src="https://github.com/user-attachments/assets/80e25d32-9c46-4258-a181-e87a41a7053b" />

## Explanation

### 1. How horizontal swipe was implemented
Horizontal swipe navigation is implemented using a native Flutter **`TabBarView`** synchronized with a shared **`TabController`**. 
- **User Experience**: This provides a smooth, "finger-following" transition between categories, which is standard in modern apps like Daraz or Instagram.
- **State Selection**: The `TabController` is managed by the `ProductController` (GetX), allowing it to synchronize the current category data with the UI across both the sticky `TabBar` and the `TabBarView`.

### 2. Who owns the vertical scroll and why?
The vertical scroll is owned by a **`NestedScrollView`** architecture.
- **Outer Scrollable**: The `SliverAppBar` (banner, search bar, and sticky tab bar) is part of the `NestedScrollView`'s outer scrollable area.
- **Inner Scrollables**: Each tab contains its own independent `CustomScrollView`.
- **Reasoning**: This architecture is the most robust way to achieve a "Shared Header" that collapses across all tabs while allowing each tab to maintain its own unique content and offset. By using `SliverOverlapAbsorber` and `SliverOverlapInjector`, we ensure the content doesn't disappear behind the sticky header.

### 3. Trade-offs or limitations of the approach
- **Complexity**: `NestedScrollView` is significantly more complex to coordinate than a single `CustomScrollView`. It requires careful use of `SliverOverlapAbsorber` and `SliverOverlapInjector` to prevent content from being obscured.
- **Memory/Persistence**: Maintaining independent positions for many tabs consumes more memory. We mitigated this by using **`PageStorageKey`**, which persists the scroll offset efficiently without keeping all widgets in memory.
- **Notch Handling**: We had to manually adjust the `toolbarHeight` and `titlePadding` of the `SliverAppBar` to ensure the title doesn't overlap with the device's camera notch when collapsed.

---

## Technical Stack
- **Framework**: Flutter
- **State Management**: GetX (for business logic and TabController management)
- **API**: FakeStore API (https://fakestoreapi.com)
- **Architecture**: Slivers + NestedScrollView

## Run Instructions

1.  **Clone the project**
2.  **Fetch dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the application**:
    ```bash
    flutter run
    ```

**Credentials (Mock)**:
- **Username**: `mor_2314`
- **Password**: `83r5^_`
