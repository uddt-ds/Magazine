//
//  TravelTableViewController.swift
//  Magazine
//
//  Created by Lee on 7/12/25.
//

import UIKit

final class TravelTableViewController: UITableViewController {

    var dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
//        tableView.rowHeight = 156
    }

    private func setupNavigationBar() {
        let title = "도시 상세 정보"
        navigationItem.title = title
        navigationController?.navigationBar.scrollEdgeAppearance = .init()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(#function)
        return dataManager.travelInfo.travel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function, "\(indexPath.row)")
        if dataManager.travelInfo.travel[indexPath.row].ad == false {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as? TravelCell else { return .init() }
            cell.configureCell(dataManager.travelInfo.travel[indexPath.row])

            cell.likeButton.tag = indexPath.row

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "adCell", for: indexPath) as? AdCell else { return .init() }

            let adColors: [UIColor] = [.paseutelPink, .paseutelGreen, .paseutelBlue]
            let index = adIndex(indexPath)
            cell.adCellBgView.backgroundColor = adColors[index]

            cell.configureLabel(dataManager.travelInfo.travel[indexPath.row])
            return cell
        }
    }


//    // 섹션으로 분기할 때는 아래의 방법으로도 가능
//        switch indexPath.section {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as? TravelCell else { return .init() }
//            cell.configureCell(dataManager.travelData[indexPath.row])
//
//            let id = dataManager.travelData[indexPath.row].id
//            let action = UIAction { [weak self] _ in
//                self?.likeButtonToggle(id)
//            }
//            cell.likeButton.removeTarget(nil, action: nil, for: .allEvents)
//            cell.likeButton.addAction(action, for: .touchUpInside)
//
//            return cell
//
//        case 1:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "adCell", for: indexPath) as? AdCell else { return .init() }
//            cell.configureLabel(dataManager.adData[indexPath.row])
//            return cell
//
//        default:
//            return UITableViewCell()
//        }


//    // 광고 셀의 인덱스가 맞지 않아서 분기처리 해보려 했으나, 아래 방법으로 불가능
//        var num = indexPath.row
//
//        if dataManager.travelInfo.travel[indexPath.row].ad == true {
//            num = indexPath.row + 1
//        } else {
//            cell.likeButton.tag = num
//        }

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

    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 2
    //    }

//    private func likeButtonToggle(_ id: UUID) {
//        guard let index = dataManager.travelInfo.travel.firstIndex(where: { $0.id == id }) else { return }
//        dataManager.travelInfo.travel[index].like?.toggle()
//        tableView.reloadData()
//    }
}
