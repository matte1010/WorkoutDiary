//
//  StartWorkoutView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-29.
//

import SwiftUI

struct StartWorkoutView: View {

    @State private var workout: Workout
    @ObservedObject var viewModel: ViewModel
    @State private var isPresentingStartWorkout = false
    
    func updateSets(for exercise: Exercise, to newCount: Int) {
        if let index = workout.exercises.firstIndex(where: { $0.id == exercise.id }) {
            var exercise = workout.exercises[index]
            exercise.sets = Array(repeating: ExerciseSet(id: UUID(), weight: "", reps: ""), count: newCount)
            workout.exercises[index] = exercise
        }
    }
    
    init(workout: Workout, viewModel: ViewModel) {
        self._workout = State(initialValue: workout)
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            List {
                ForEach(workout.exercises) { exercise in
                    Section(header: Text(exercise.name)) {
                        Stepper("Sets \(exercise.sets.count)", onIncrement: {
                            updateSets(for: exercise, to: exercise.sets.count + 1)
                        }, onDecrement: {
                            if exercise.sets.count > 0 {
                                updateSets(for: exercise, to: exercise.sets.count - 1)
                            }
                        })
                    }
                }
            }
            Button(action: {
                let startedWorkout = Workouts(id: UUID(), date: Date(), workout: workout)
                viewModel.startedWorkouts.append(startedWorkout)
                isPresentingStartWorkout.toggle()
            }) {
                Text("Start Workout")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isPresentingStartWorkout) {
                // Show workout view
                StartedWorkoutView(viewModel: viewModel, selectedWorkout: $viewModel.startedWorkouts.last!, isPresented: $isPresentingStartWorkout)
            }
        }
        .navigationTitle(workout.workoutName)
    }
}

struct StartWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StartWorkoutView(workout: Workout(id: UUID(), workoutName: "Push", exercises: [Exercise(id: UUID(), name: "bench", sets: [ExerciseSet(id: UUID(), weight: "", reps: "")]), Exercise(id: UUID(), name: "Dips", sets: [ExerciseSet(id: UUID(), weight: "", reps: ""), ExerciseSet(id: UUID(), weight: "", reps: "")])]), viewModel: ViewModel())
        }
    }
}

