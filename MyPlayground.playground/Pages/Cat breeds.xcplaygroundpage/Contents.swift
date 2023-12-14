import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


struct Breed: Codable,CustomStringConvertible {
    let id:String
    let name:String
    let temperament:String
    let breedExplaination:String
    let energy_level : Int
    let ishairless : Bool
    //let image : breedImage
    
    
    var description : String{
        return "breed with name: \(name) and id \(id) with energy_level \(energy_level) isHirless \(ishairless ? "Yes":"No")"
    }
    enum CodingKeys: String,CodingKey{
        case id
        case name
        case temperament
        case breedExplaination  = "description"
        case energy_level
        case ishairless = "hairless"
       // case image
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        temperament = try values.decode(String.self, forKey: .temperament)
        breedExplaination = try values.decode(String.self ,forKey: .breedExplaination)
        energy_level = try values.decode(Int.self, forKey: .energy_level)
        
        let hairless = try values.decode(Int.self, forKey: .ishairless)
        ishairless = hairless == 1
        //image = try values.decode(breedImage.self, forKey: .image)

    }
}

struct breedImage :Codable{
    let id :String
    let url :String
    let width:Int
    let height: Int
}

let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=1")!



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
            let breeds = try decoder.decode([Breed].self, from: data)
            print(breeds)

            
        } catch {
            print(error)
        }
    }
    
    PlaygroundPage.current.finishExecution()
}
task.resume()


