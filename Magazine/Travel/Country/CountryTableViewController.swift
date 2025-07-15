//
//  CountryTableViewController.swift
//  Magazine
//
//  Created by Lee on 7/15/25.
//

import UIKit

class CountryTableViewController: UITableViewController {

    @IBOutlet var segMenu: UISegmentedControl!

    @IBOutlet var searchTextField: UITextField!
    
    let cityData = CityInfo()

    var currentData = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        searchTextFieldUI()
        segmentedMenuUI()

        let nib = UINib(nibName: String(describing: CountryTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: CountryTableViewCell.self))

        currentData = cityData.city
    }

    private func setupNavigation() {
        navigationController?.navigationBar.scrollEdgeAppearance = .init()
        navigationItem.title = "인기 도시"
    }

    private func searchTextFieldUI() {
        let holder = "검색어를 입력해주세요"
        searchTextField.placeholder = holder
        searchTextField.borderStyle = .line
        searchTextField.textAlignment = .left
        searchTextField.textColor = .gray
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
//        searchTextField.spellCheckingType = .no
    }

    private func segmentedMenuUI() {
        segMenu.selectedSegmentIndex = 0
        segMenu.setTitle("모두", forSegmentAt: 0)
        segMenu.setTitle("국내", forSegmentAt: 1)
        segMenu.insertSegment(withTitle: "해외", at: 2, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self), for: indexPath) as! CountryTableViewCell
        cell.configureCell(with: currentData[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    @IBAction func segmentedTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentData = cityData.city
        case 1:
            currentData = cityData.city.filter({ $0.domesticTravel })
        case 2:
            currentData = cityData.city.filter({ !$0.domesticTravel })
        default:
            currentData = cityData.city
        }
        tableView.reloadData()
    }

    @IBAction func textFieldEndExit(_ sender: UITextField) {
        guard let keyword = sender.text?.uppercased(), !keyword.isEmpty else {
            segmentedTapped(segMenu)
            return
        }

        let nonSpaceKeyword = keyword.trimmingCharacters(in: .whitespaces)

        //TODO: 국내, 국외 구분 검색 기능 필요

        currentData = cityData.city.filter({
            $0.cityName == nonSpaceKeyword ||
            $0.cityEnglishName == nonSpaceKeyword ||
            $0.cityExplain == nonSpaceKeyword ||
            $0.upperKeyword == nonSpaceKeyword
        })

        tableView.reloadData()
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {

        if sender.text == "" {
            segmentedTapped(segMenu)
        }

        let krKeywordArr = cityData.city.map { $0.cityName }
        let enKeywordArr = cityData.city.map { $0.cityEnglishName }
        let explainKeywordArr = cityData.city.map { $0.cityExplain }

        if krKeywordArr.contains(where: { $0 == sender.text }) ||
            enKeywordArr.contains(where: { $0 == sender.text }) ||
            explainKeywordArr.contains(where: { $0 == sender.text })
        {
            sender.textColor = .brown
        } else {
            sender.textColor = .black
        }
    }
}
