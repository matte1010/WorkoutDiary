//
//  ExerciseView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-17.
//

import SwiftUI

struct ExerciseView: View {
    @State private var weight = ""
    @State private var reps = ""
    @State private var exerciseList: [Exercise] = [] // Define a data structure for Exercise

    var body: some View {
        List {
            Section(header: Text("Exercise Name")
                        .font(.headline)
                        .fontWeight(.bold)
            ) {
                ForEach(exerciseList.indices, id: \.self) { index in
                    HStack {
                        TextField("Weight", text: Binding(
                            get: { exerciseList[index].weightString },
                            set: { exerciseList[index].weightString = $0 }
                        ))
                        .keyboardType(.numberPad)
                        Text("kg")
                        
                        Spacer()

                        TextField("Reps", text: Binding(
                            get: { exerciseList[index].repsString },
                            set: { exerciseList[index].repsString = $0 }
                        ))
                        .keyboardType(.numberPad)
                        Text("reps")
                    }
                }

                HStack {
                    TextField("Weight", text: $weight)
                        .keyboardType(.numberPad)
                    Text("kg")

                    Spacer()

                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                    Text("reps")

                    Button(action: {
                        addExercise()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.green)
                    }
                }
            }
        }
    }

    func addExercise() {
        let weightValue = Double(weight) ?? 0.0
        let repsValue = Int(reps) ?? 0

        let newExercise = Exercise(weight: weightValue, reps: repsValue)
        exerciseList.append(newExercise)

        // Clear the text fields after adding an exercise
        weight = ""
        reps = ""
    }
}

// Data structure for Exercise
struct Exercise: Hashable {
    var weight: Double
    var reps: Int

    var weightString: String {
        get { weight == 0.0 ? "" : "\(weight)" }
        set { weight = Double(newValue) ?? 0.0 }
    }

    var repsString: String {
        get { reps == 0 ? "" : "\(reps)" }
        set { reps = Int(newValue) ?? 0 }
    }
}









#Preview {
    ExerciseView()
}
