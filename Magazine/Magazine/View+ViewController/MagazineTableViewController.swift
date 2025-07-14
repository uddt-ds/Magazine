//
//  MagazineTableViewController.swift
//  MagazineProject
//
//  Created by Lee on 7/11/25.
//

import UIKit

final class MagazineTableViewController: UITableViewController {

    private let magazineData = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        designTableViewUI()
        setupTabBar()
        
        let xib = UINib(nibName: "MagazineCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "MagazineCell")
    }

    private func setupNavigationBar() {
        let title = "SeSAC TRAVEL"
        navigationItem.title = title
        navigationController?.navigationBar.scrollEdgeAppearance = .init()
    }

    private func designTableViewUI() {
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineData.magazine.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineCell", for: indexPath) as? MagazineCell else { return .init() }

        cell.configureCell(magazineData.magazine[indexPath.row])

        return cell
    }

    private func setupTabBar() {
        tabBarController?.tabBar.tintColor = .black
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
