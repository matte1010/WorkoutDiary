//
//  NinjaAPI.swift
//  WorkoutDiary
//
//  Created by Arin Rahim on 2023-12-18.
//

import Foundation
import CoreData

class NinjaAPI: ObservableObject 
{

    @Published var exercises = [Exercises]()

       func loadData(completion:@escaping ([Exercises]) -> ()) 
    {
        let muscle = "biceps".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/exercises?muscle="+muscle!)!
        var request = URLRequest(url: url)
        request.setValue("zMoGk9CWn1sKaLAHYDKrzA==Yt5VgZpBgYNbebEx", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) 
        { (data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}

struct Exercises: Decodable
{
    //var id = UUID()
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
}

struct CoreDataExercises: Codable
{
    var exerciseName: String
    var muscle: String
}
