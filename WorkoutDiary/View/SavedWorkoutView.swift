//
//  SavedWorkoutView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-27.
//

import SwiftUI

struct SavedWorkoutView: View {
    @StateObject var viewModel: ViewModel
    var selectedWorkoutIndex: Int

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.savedWorkouts[selectedWorkoutIndex].exercises.indices, id: \.self) { exerciseIndex in
                    let exercise = viewModel.savedWorkouts[selectedWorkoutIndex].exercises[exerciseIndex]
                    Section(header: Text(exercise.name).font(.headline).bold()) {
                        ForEach(exercise.sets.indices, id: \.self) { setIndex in
                            HStack {
                                TextField("Weight", text: Binding(
                                    get: {
                                        exercise.sets[setIndex].weight
                                    },
                                    set: { newValue in
                                        viewModel.savedWorkouts[selectedWorkoutIndex].exercises[exerciseIndex].sets[setIndex].weight = newValue
                                    }
                                ))
                                .keyboardType(.numberPad)

                                Text("kg")
                                Spacer()

                                TextField("Reps", text: Binding(
                                    get: {
                                        exercise.sets[setIndex].reps
                                    },
                                    set: { newValue in
                                        viewModel.savedWorkouts[selectedWorkoutIndex].exercises[exerciseIndex].sets[setIndex].reps = newValue
                                    }
                                ))
                                .keyboardType(.numberPad)

                                Text("reps")
                            }
                            .listRowBackground(Color.gray)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    viewModel.savedWorkouts[selectedWorkoutIndex].exercises[exerciseIndex].sets.remove(at: setIndex)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }

                        Button(action: {
                            viewModel.savedWorkouts[selectedWorkoutIndex].exercises[exerciseIndex].sets.append(ExerciseSet(id: UUID(), weight: "", reps: ""))
                        }) {
                            Text("Add Set")
                                .foregroundStyle(Color(.white))
                        }
                        .listRowBackground(Color(red: 0, green: 100/255, blue: 0))
                    }
                }
            }
            .background(LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Exercise list")
        .scrollDismissesKeyboard(.immediately)
    }
    
}

struct SavedWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        SavedWorkoutView(viewModel: ViewModel(), selectedWorkoutIndex: 0)
    }
}


extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

