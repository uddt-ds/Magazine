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
    }

    private func setupNavigationBar() {
        let title = "SeSAC TRAVEL"
        navigationItem.title = title
    }

    private func designTableViewUI() {
        tableView.separatorStyle = .none
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineData.magazine.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "magazineCell", for: indexPath) as? MagazineTableViewCell else { return .init() }

        cell.configureCell(magazineData.magazine[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440
    }
}
