//
//  GSDViewController.swift
//  AnderserRequest
//
//  Created by admin on 03.10.2019.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit

class GSDViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageModel: [ImageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "GCDCell", bundle: nil), forCellReuseIdentifier: "GCDCell")
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        tableView.reloadData()
        
        
    }
    
    private func getData() {
          let urlString = "https://randomuser.me/api/?inc=picture&results=5"
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

                                  let avatarImage = ImageModel()

                                  if let avatar = data["picture"] as? [String: Any] {
                                      if let thumbnail = avatar["thumbnail"] as? String {
                                        avatarImage.thumbnail = thumbnail
                                    }
                                  }

                                  self.imageModel.append(avatarImage)
                              }
                              DispatchQueue.main.async {
                                  self.tableView.reloadData()
                                  self.createAlertController(title: "Download done", message: "👍")
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
    
    private func createAlertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension GSDViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "GCDCell", for: indexPath) as! GCDCell
        cell.update(image: imageModel[indexPath.row])
        return cell
    }
}
