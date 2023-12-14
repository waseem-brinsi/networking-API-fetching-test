import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


struct User: Codable {
    let id:Int
    let email:String
    let first_name:String
    let last_name : String
    let avatar : String

    

    enum CodingKeys: String,CodingKey{
        case id
        case email
        case first_name
        case last_name
        case avatar

        
    }
    

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        first_name = try values.decode(String.self ,forKey: .first_name)
        last_name = try values.decode(String.self, forKey: .last_name)
        avatar = try values.decode(String.self, forKey: .avatar)
        

    }
}


struct ApiResponse: Codable {
    let page: Int
    let data: [User]
}

let url = URL(string: "https://reqres.in/api/users")!



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
            let users = try decoder.decode(ApiResponse.self, from: data)
            print(users.data[0].email)

            
        } catch {
            print(error)
        }
    }
    PlaygroundPage.current.finishExecution()
}
task.resume()



