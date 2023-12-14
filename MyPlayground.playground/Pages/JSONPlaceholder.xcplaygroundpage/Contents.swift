import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


struct Post: Codable {
    
    let userId : Int
    let id : Int
    let title : String
    let body : String
    
    
}



let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

var request = URLRequest(url: url)
request.httpMethod = "GET"
//request.allHTTPHeaderFields = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NjY3ZTQ4NWI4NDUzMWYwNDAwZGQ3YyIsImlhdCI6MTcwMTIxNjYxOSwiZXhwIjoxNzA4OTkyNjE5fQ.5PvPZ95DzElKbPOM4cK6-fu1KvPeFdJEWr_qeLL8ZBE"]
//request.allHTTPHeaderFields = ["x-api-key": "API_key"]

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
    if let response = response as? HTTPURLResponse , !(200...299).contains(response.statusCode){
        print(response.statusCode)
    }

    if let error = error{
        print(error.localizedDescription)
    }
    
    
    let decoder = JSONDecoder()
    
    if let data = data{
        
        do {
            let posts = try decoder.decode([Post].self, from: data)z
            print(posts.count)
        } catch {
            print(error)
        }
    }
    PlaygroundPage.current.finishExecution()
}
task.resume()

