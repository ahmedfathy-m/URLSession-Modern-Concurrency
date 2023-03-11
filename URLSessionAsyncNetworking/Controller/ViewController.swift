//
//  ViewController.swift
//  URLSessionAsyncNetworking
//
//  Created by Ahmed Fathy on 08/03/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private(set) var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        makeANetworkCall()
    }
    
    fileprivate func makeANetworkCall() {
        Task {
            self.posts = try await Webservice.main.loadService(route: Router.placeholder, model: [Post].self)
            tableView.reloadData()
        }
    }
}


