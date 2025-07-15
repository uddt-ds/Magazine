//
//  CountryTableViewController.swift
//  Magazine
//
//  Created by Lee on 7/15/25.
//

import UIKit

class CountryTableViewController: UITableViewController {

    @IBOutlet var segMenu: UISegmentedControl!
    
    let cityData = CityInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        segmentedMenuUI()

        let nib = UINib(nibName: String(describing: CountryTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: CountryTableViewCell.self))
    }

    private func setupNavigation() {
        navigationController?.navigationBar.scrollEdgeAppearance = .init()
        navigationItem.title = "인기 도시"
    }

    private func segmentedMenuUI() {
        segMenu.selectedSegmentIndex = 0
        segMenu.setTitle("모두", forSegmentAt: 0)
        segMenu.setTitle("국내", forSegmentAt: 1)
        segMenu.insertSegment(withTitle: "해외", at: 2, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segMenu.selectedSegmentIndex {
        case 0:
            return cityData.city.count
        case 1:
            return cityData.domesticData.count
        case 2:
            return cityData.overseaData.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segMenu.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self), for: indexPath) as! CountryTableViewCell

            cell.configureCell(with: cityData.city[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self), for: indexPath) as! CountryTableViewCell

            cell.configureCell(with: cityData.domesticData[indexPath.row])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self), for: indexPath) as! CountryTableViewCell
            cell.configureCell(with: cityData.overseaData[indexPath.row])
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    @IBAction func segmentedTapped(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}
