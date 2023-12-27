//
//  AddWorkoutView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-27.
//

import SwiftUI

struct AddWorkoutView: View {
    
    @State private var workoutName = ""
    @State private var exercises = [Exercise]()
    @StateObject var viewModel: ViewModel
    
    @State private var selectedMuscleGroup: MuscleGroup? = nil
        
    @State private var selectedExercise: Exercise? = nil
        @State private var selectedExercises = Set<Exercise>()
        
        var body: some View {
            Form {
                
                Section {
                    TextField("Workout Name", text: $workoutName)
                }
                
                Section(header: Text("Exercises")) {
                    
                    ForEach(viewModel.muscleGroups) { muscleGroup in
                        
                        Section(header:
                            Text(muscleGroup.name)
                                .onTapGesture {
                                    self.selectedMuscleGroup = muscleGroup
                                }
                        ) {
                            
                            if self.selectedMuscleGroup?.id == muscleGroup.id {
                                
                                ForEach(muscleGroup.exercises) { exercise in
                                    
                                    Button(action: {
                                        self.selectedExercise = exercise
                                    }) {
                                        Text(exercise.name)
                                    }
                                    
                                }
                                
                                Button("Add Exercise") {
                                    if let exercise = self.selectedExercise {
                                        self.selectedExercises.insert(exercise)
                                        self.selectedExercise = nil
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                Section(header: Text("Added Exercises")) {
                   ForEach(Array(selectedExercises)) { exercise in
                      Text(exercise.name)
                   }
                }
                
                Section {
                    Button("Save Workout") {
                        let workout = Workout(id: UUID(), workoutName: self.workoutName, exercises: Array(self.selectedExercises))
                        // Save workout
                        selectedExercises = []
                        viewModel.saveWorkout(workout: workout)
                        workoutName = ""
                    }
                }
                
            }
        }
}

#Preview {
    AddWorkoutView(viewModel: ViewModel())
}
