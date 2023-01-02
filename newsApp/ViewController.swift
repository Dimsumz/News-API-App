//
//  ViewController.swift
//  newsApp
//
//  Created by Jonathan Ouyang on 1/1/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://newsapi.org/v2/everything?q=Apple&from=2023-01-01&sortBy=popularity&apiKey=059a944b5cb9401d852ffb9e841301c4"
        getData(from: url)
        print("Test")
    }
    
    //https://newsapi.org/v2/everything?q=Apple&from=2023-01-01&sortBy=popularity&apiKey=059a944b5cb9401d852ffb9e841301c4

    func getData(from url: String) {
        
        //call website for data
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            //have data
            var result: Response?
            do {
                //map the bytes to the struct, in this case Response
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            //we now have our object
            guard let json = result else {
                return
            }
            
            
            print(json.status)
            print(json.totalResults)
            print(json.articles[0].author)
            json.articles.forEach { a in
                print(a.author)
            }
            
            //print(json.articles.source.id)
            
        }).resume()
        //the .resume() is going to fire the request
    }

}


struct Response: Codable {
    let status: String
    let totalResults: Int
    let articles: [articleResults]
}

struct articleResults: Codable {
    let author: String
    let title: String
    let content: String
    let url: String
}
/*
struct sourceResults: Codable {
    let name: String
    let id: String?
}*/
