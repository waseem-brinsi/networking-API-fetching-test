import UIKit
import PlaygroundSupport



PlaygroundPage.current.needsIndefiniteExecution = true


let url = URL(string: "https://cdn2.thecatapi.com/images/des.jpg")!

var request = URLRequest(url: url)
request.httpMethod = "GET"
//request.allHTTPHeaderFields = ["x-api-key": "API_key"]


let task = URLSession.shared.dataTask(with: url) { data, response, error in
    
  
    
    if let data = data,
        let image = UIImage(data: data) {
        print("success")
        let i = image
      
    }
    PlaygroundPage.current.finishExecution()
}

task.resume()

