//
//  ViewModel.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-21.
//

import Foundation

class ViewModel : ObservableObject {
    
    var exercisesAPI = [ExercisesAPI]()
    @Published var exercises = [Exercise]() //Array for saving the exercises for each api call.
    @Published var muscleGroups = [MuscleGroup]() //Array for Saving all exercises for each muscle group.
    @Published var savedWorkouts = [Workout]() //Array for storing our workouts with name and all corresponding data.
    @Published var startedWorkouts = [Workouts]()
    
    var lastStartedWorkout: Workouts? {
            startedWorkouts.last
        }
    
    init() {
        getExercises(forMuscle: "biceps")
        getExercises(forMuscle: "chest")
        //savedWorkouts = []
    }
    
    //Send in a defined muscle to get exercises
    func getExercises(forMuscle muscle: String) {
            NinjaAPI().loadData(muscle: muscle) { (exercises) in
                // This code is executed when the data is loaded
                var muscleGroupExercises = [Exercise]()

                // Process the loaded data
                for exercise in exercises {
                    let newExercise = Exercise(id: UUID(), name: exercise.name, sets: [ExerciseSet(id: UUID(), weight: "", reps: "")])
                    self.exercises.append(newExercise)
                    muscleGroupExercises.append(newExercise)
                }

                // Create a single MuscleGroup for the muscle and add the corresponding exercises
                let muscleGroup = MuscleGroup(id: UUID(), name: muscle, exercises: muscleGroupExercises)
                self.muscleGroups.append(muscleGroup)

                // Now the exercises array and muscleGroups array are populated correctly
                print("View exercises: \(self.exercises)")
                print("View muscleGroups: \(self.muscleGroups)")
            }
            // At this point, exercisesAPI may not be populated yet, so printing it here may show an empty array
            print(exercisesAPI)
    }
    
    // Function to save the workout to the array after defining it in the AddWorkoutView
    func saveWorkout(workout: Workout) {
        // Add to published array
        savedWorkouts.append(workout)
        print(savedWorkouts)

    }
    
}
