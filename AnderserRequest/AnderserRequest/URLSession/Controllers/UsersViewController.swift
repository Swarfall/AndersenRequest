//
//  ViewController.swift
//  AnderserRequest
//
//  Created by admin on 30.09.2019.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var userModel: [UserModel] = []
    var requestParametrModel = RequestParametrModel()
    var user = UserModel()
    let methodStart = Date()
    let methodFinish = Date()
    var executionTime = TimeInterval()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        executionTime = methodFinish.timeIntervalSince(methodStart)
        tableView.register(UINib(nibName: "UsersCell", bundle: nil), forCellReuseIdentifier: "UsersCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        tableView.reloadData()
    }
    
    private func getData() {
        let urlString = "\(requestParametrModel.randomRequestURL)\(requestParametrModel.resultsCount)"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                guard let data = data else { return }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    {
                        if let result = json["results"] as? [[String: Any]] {
                        if result.count > 0 {

                            for data in result {

                                let user = UserModel()

                                if let avatar = data["picture"] as? [String: Any] {
                                    if let thumbnail = avatar["thumbnail"] as? String {
                                        user.thumbnailImage = thumbnail
                                    }
                                    if let large = avatar["large"] as? String {
                                        user.largeImage = large
                                    }
                                }

                                if let name = data["name"] as? [String: Any] {
                                    if let firstName = name["first"] as? String {
                                        user.name = firstName
                                    }
                                    if let lastName = name["last"] as? String {
                                        user.surname = lastName
                                    }
                                }

                                if let email = data["email"] as? String {
                                    user.email = email
                                }

                                if let location = data["location"] as? [String: Any] {
                                    if let country = location["country"] as? String {
                                        user.country = country
                                    }
                                    if let city = location["city"] as? String {
                                        user.city = city
                                    }
                                }

                                self.userModel.append(user)
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                print("Execution time: \(self.executionTime)")
                            }
                        }
                        }
                    }
                } catch let error as NSError {
                    debugPrint("Error: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath) as! UsersCell
        cell.update(user: userModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.user = userModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
