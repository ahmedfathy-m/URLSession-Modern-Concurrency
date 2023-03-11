//
//  ViewController+UITableViewDataSource.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 11/03/2023.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = self.posts[indexPath.row].title
        cell.detailTextLabel?.text = self.posts[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
}
