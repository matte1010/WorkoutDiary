//
//  HomeScreen.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-17.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            WorkoutView().tabItem { Text("Workout") }.tag(1)
            Text("Tab Content 2").tabItem { Text("Statistics") }.tag(2)
            Text("Tab Content 3").tabItem { Text("Tab Label 3") }.tag(3)
            Text("Tab Content 4").tabItem { Text("Tab Label 4") }.tag(4)
        }
    }
}

#Preview {
    HomeScreen()
}
