//
//  ExercisesListView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-18.
//

import SwiftUI

struct ExercisesListView: View {
    let workouts: [Exercise]

    var body: some View {
        List {
            ForEach(groupedWorkouts["Push"] ?? [], id: \.id) { exercise in
                Section(header: Text(exercise.name)) {
                    ForEach(exercise.sets) { _ in
                        HStack {
                            Text("Exercise: \(exercise.name)")
                        }
                        .listRowBackground(Color.gray)
                    }
                }
            }
        }
        .background(LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all))
        .scrollContentBackground(.hidden)
        .navigationTitle("Exercise List")
    }

    var groupedWorkouts: [String: [Exercise]] {
        Dictionary(grouping: workouts, by: { $0.name })
    }
}

struct ExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesListView(workouts: [
            Exercise(id: UUID(), name: "Push workout", sets: [
                ExerciseSet(id: UUID(), weight: "100", reps: "10"),
                ExerciseSet(id: UUID(), weight: "120", reps: "8"),
            ]),
            Exercise(id: UUID(), name: "Push workout", sets: [
                ExerciseSet(id: UUID(), weight: "80", reps: "12"),
                ExerciseSet(id: UUID(), weight: "100", reps: "10"),
            ]),
            Exercise(id: UUID(), name: "Pull workout", sets: [
                ExerciseSet(id: UUID(), weight: "90", reps: "12"),
                ExerciseSet(id: UUID(), weight: "110", reps: "10"),
            ])
        ])
    }
}



