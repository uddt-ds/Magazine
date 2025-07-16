//
//  TravelTableViewController.swift
//  Magazine
//
//  Created by Lee on 7/12/25.
//

import UIKit
import Toast

final class TravelTableViewController: UITableViewController {

    var dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        let xib = UINib(nibName: "TravelCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "TravelCell")

        let xibAdCell = UINib(nibName: "AdCell", bundle: nil)
        tableView.register(xibAdCell, forCellReuseIdentifier: "AdCell")
    }

    private func setupNavigationBar() {
        let title = "도시 상세 정보"
        navigationItem.title = title
        navigationController?.navigationBar.scrollEdgeAppearance = .init()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.travelInfo.travel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataManager.travelInfo.travel[indexPath.row].ad == false {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCell", for: indexPath) as? TravelCell else { return .init() }
            cell.configureCell(dataManager.travelInfo.travel[indexPath.row])

            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdCell", for: indexPath) as? AdCell else { return .init() }

            let adColors: [UIColor] = [.paseutelPink, .paseutelGreen, .paseutelBlue]
            let index = adIndex(indexPath)
            cell.adCellBgView.backgroundColor = adColors[index]
            cell.configureLabel(dataManager.travelInfo.travel[indexPath.row])

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataManager.travelInfo.travel[indexPath.row]
        if dataManager.travelInfo.travel[indexPath.row].ad == false {
            let sb = UIStoryboard(name: TravelDetailViewController.identifier, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TravelDetailViewController.identifier) as! TravelDetailViewController
            vc.data = data
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.topItem?.title = ""
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let id = String(describing: AdDetailViewController.self)
            let sb = UIStoryboard(name: id, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: id) as! AdDetailViewController

            vc.adData.title = dataManager.travelInfo.travel[indexPath.row].title

            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.navigationBar.scrollEdgeAppearance = .init()
            let leftBarButton = UIBarButtonItem(title: "1", style: .plain, target: nil, action: nil)
            nav.navigationItem.leftBarButtonItem = leftBarButton
            present(nav, animated: true)
        }
    }

    @objc func xmarkTapped() {
        dismiss(animated: true)
    }

    private func adIndex(_ indexPath: IndexPath) -> Int {
        let totalData = dataManager.travelInfo.travel
        let adData = totalData.filter { $0.ad == true }

        let currentAdData = totalData[indexPath.row]
        
        return adData.firstIndex { $0.title == currentAdData.title } ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentData = dataManager.travelInfo.travel[indexPath.row]
        if currentData.ad == true {
            return 104
        } else {
            return 156
        }
    }

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        dataManager.travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
}
