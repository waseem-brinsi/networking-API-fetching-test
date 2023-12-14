import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//let url = URL(string: "https://www.apple.com")!
//let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=1")!
let url = URL(string: "http://172.18.21.85:8000/places/")!
//let url = URL(string: "https://cdn2.thecatapi.com/images/des.jpg")!

var request = URLRequest(url: url)
request.httpMethod = "GET"
request.allHTTPHeaderFields = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NjY3ZTQ4NWI4NDUzMWYwNDAwZGQ3YyIsImlhdCI6MTcwMTIxNjYxOSwiZXhwIjoxNzA4OTkyNjE5fQ.5PvPZ95DzElKbPOM4cK6-fu1KvPeFdJEWr_qeLL8ZBE"]
//request.allHTTPHeaderFields = ["x-api-key": "API_key"]

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
    if let response = response as? HTTPURLResponse , !(200...299).contains(response.statusCode){
        print(response.statusCode)
    }
    
    if let error = error{
        print(error.localizedDescription)
    }
    
    if let data = data,
        let file = String(data: data, encoding: .utf8) {
        print(file)
      
    }
    PlaygroundPage.current.finishExecution()
}
task.resume()

