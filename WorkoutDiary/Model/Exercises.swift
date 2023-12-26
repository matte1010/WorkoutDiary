//
//  Exercises.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-17.
//

import Foundation

struct MuscleGroup: Hashable {
    let name: String
    var exercises: [Exercise]
}

struct ExerciseSet: Identifiable, Equatable, Hashable {
    let id: UUID
    var weight: String
    var reps: String
}

struct Exercise: Identifiable, Equatable, Hashable {
    let id: UUID
    var name: String
    var sets: [ExerciseSet]
}
