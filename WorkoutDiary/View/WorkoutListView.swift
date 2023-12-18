//
//  ExercisesListView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-18.
//

import SwiftUI

struct Workout: Identifiable {
    let id: UUID
    var name: String
    var exercises: [Exercise]
}

struct WorkoutListView: View {
    @State private var workouts: [Workout] = [
        Workout(id: UUID(), name: "Push Workout", exercises: [
            Exercise(id: UUID(), name: "Bench Press", sets: [
                ExerciseSet(id: UUID(), weight: "100", reps: "10"),
                ExerciseSet(id: UUID(), weight: "50", reps: "15"),
            ]),
            Exercise(id: UUID(), name: "Dips", sets: [
                ExerciseSet(id: UUID(), weight: "100", reps: "10"),
                ExerciseSet(id: UUID(), weight: "50", reps: "15"),
            ]),
            // Add more exercises if needed
        ]),
        
        Workout(id: UUID(), name: "Pull Workout", exercises: [
            Exercise(id: UUID(), name: "Pullups", sets: [
                ExerciseSet(id: UUID(), weight: "100", reps: "10"),
                ExerciseSet(id: UUID(), weight: "50", reps: "15"),
            ]),
            Exercise(id: UUID(), name: "Deadlifts", sets: [
                ExerciseSet(id: UUID(), weight: "100", reps: "10"),
                ExerciseSet(id: UUID(), weight: "50", reps: "15"),
            ]),
            // Add more exercises if needed
        ]),
        // Add more workouts if needed
    ]

    // Extract workout names from the array
    var workoutNames: [String] {
        workouts.map { $0.name }
    }

    var body: some View {
        NavigationView {
            List(workoutNames, id: \.self) { workoutName in
                NavigationLink(destination: WorkoutDetail(workout: workouts.first { $0.name == workoutName })) {
                    Text(workoutName)
                }
                .listRowBackground(Color.gray)
            }
            .background(LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
            .scrollContentBackground(.hidden)
            .navigationTitle("Workout List")
        }
    }
}

struct WorkoutDetail: View {
    var workout: Workout?

    var body: some View {
        if let workout = workout {
            List(workout.exercises) { exercise in
                Text("Exercise: \(exercise.name)")
                    .listRowBackground(Color.gray)
                // Display other details or customize as needed
            }
            .background(LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
            .scrollContentBackground(.hidden)
            .navigationTitle(workout.name)
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}



