//
//  ViewController.swift
//  newsApp
//
//  Created by Jonathan Ouyang on 1/1/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func buttonOutlet(_ sender: UIButton) {
        print(titleArray)
        print(titleArray.count)
        tableView.reloadData()
    }
    
    var titleArray: [String] = []
    var descriptionArray: [String] = []
    var imageArray: [String] = []
    var urlArray: [String] = []
    let cellIdentifier = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let url = "https://newsapi.org/v2/everything?q=Apple&from=2023-01-02&sortBy=popularity&apiKey=059a944b5cb9401d852ffb9e841301c4"
        getData(from: url)
                
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.testArray.count
        return self.titleArray.count
        
        //return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: newsViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! newsViewCell
        
        cell.titleLabel.text = self.titleArray[indexPath.row]
        cell.contentLabel.text = self.descriptionArray[indexPath.row]
        //cell.titleLabel.text = self.testArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped cell number \(indexPath.row).")
        //print(titleArray)

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
            
            json.articles.forEach { a in
                self.titleArray.append(a.title)
                self.descriptionArray.append(a.content)
                self.urlArray.append(a.url)
            }
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
//    let author: String
    let title: String
    let content: String
    let url: String
    

}
/*
struct sourceResults: Codable {
    let name: String
    let id: String?
}*/
