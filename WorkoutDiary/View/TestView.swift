//
//  TestView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-18.
//

import SwiftUI

struct TestView: View {

    @State var exercises = [ExercisesAPI]()
    @State var query: String = ""
    
    func getExercises() {
        NinjaAPI().loadData { (exercises) in
            self.exercises = exercises
        }
    }
    
    var body: some View {
        Button("Button") {
            //getExercises()
        }
    }
}

#Preview {
    TestView()
}
