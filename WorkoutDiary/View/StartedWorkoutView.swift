//
//  StartedWorkoutView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-30.
//

import SwiftUI

struct StartedWorkoutView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var selectedWorkout: Workouts

    var body: some View {
        VStack {
            List {
                ForEach(selectedWorkout.workout.exercises.indices, id: \.self) { exerciseIndex in
                    let exercise = selectedWorkout.workout.exercises[exerciseIndex]
                    
                    Section(header: Text(exercise.name)) {
                        ForEach(exercise.sets.indices, id: \.self) { setIndex in
                            HStack {
                                
                                TextField("Weight", text: Binding(
                                    get: { exercise.sets[setIndex].weight },
                                    set: {
                                        selectedWorkout.workout.exercises[exerciseIndex].sets[setIndex].weight = $0
                                    }
                                ))
                                
                                Text("kg")
                                
                                TextField("Reps", text: Binding(
                                    get: { exercise.sets[setIndex].reps },
                                    set: {
                                        selectedWorkout.workout.exercises[exerciseIndex].sets[setIndex].reps = $0
                                    }
                                ))
                                
                                Text("reps")
                            }
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    selectedWorkout.workout.exercises[exerciseIndex].sets.remove(at: setIndex)
                                }
                            }
                        }
                        
                        Button("Add Set") {
                            selectedWorkout.workout.exercises[exerciseIndex].sets.append(ExerciseSet(id: UUID(), weight: "", reps: ""))
                        }
                        
                    }
                }
            }
            .navigationTitle("Workout")
        }
        
    }
}

//#Preview {
//    StartedWorkoutView(viewModel: ViewModel(), selectedWorkout: Workouts(id: UUID(), date: Date(), workout: Workout(id: UUID(), workoutName: "Push", exercises: [Exercise(id: UUID(), name: "bench press", sets: [ExerciseSet(id: UUID(), weight: "", reps: "")]), Exercise(id: UUID(), name: "Dips", sets: [ExerciseSet(id: UUID(), weight: "", reps: "")])])))
//}
