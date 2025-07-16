//
//  CountryViewController.swift
//  Magazine
//
//  Created by Lee on 7/16/25.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var searchTextField: UITextField!

    @IBOutlet var segMenu: UISegmentedControl!

    @IBOutlet var countryTableView: UITableView!

    let cityData = CityInfo()

    var currentData = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSearchTextFieldUI()
        setupSegmentedMenuUI()
        setupTableViewSeperator()

        countryTableView.rowHeight = 200

        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        countryTableView.register(nib, forCellReuseIdentifier: "CountryTableViewCell")

        countryTableView.dataSource = self
        countryTableView.delegate = self

        currentData = cityData.city
    }

    private func setupNavigation() {
        navigationController?.navigationBar.scrollEdgeAppearance = .init()
        navigationItem.title = "인기 도시"
    }

    private func setupSearchTextFieldUI() {
        let holder = "검색어를 입력해주세요"
        searchTextField.placeholder = holder
        searchTextField.borderStyle = .line
        searchTextField.textAlignment = .left
        searchTextField.textColor = .gray
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
    }

    private func setupSegmentedMenuUI() {
        segMenu.selectedSegmentIndex = 0
        segMenu.setTitle("모두", forSegmentAt: 0)
        segMenu.setTitle("국내", forSegmentAt: 1)
        segMenu.insertSegment(withTitle: "해외", at: 2, animated: true)
    }

    private func setupTableViewSeperator() {
        countryTableView.separatorStyle = .none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self), for: indexPath) as! CountryTableViewCell
        cell.configureCell(with: currentData[indexPath.row])
        return cell
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
        countryTableView.reloadData()
    }

    @IBAction func textFieldEndExit(_ sender: UITextField) {
        guard let keyword = sender.text?.uppercased(),
              !keyword.isEmpty else {
            segmentedTapped(segMenu)
            return
        }

        let nonSpacedKeyword = keyword.trimmingCharacters(in: .whitespaces)

        switch segMenu.selectedSegmentIndex {
        case 0:
            currentData = cityData.city
        case 1:
            currentData = cityData.city.filter({ $0.domesticTravel })
        case 2:
            currentData = cityData.city.filter({ !$0.domesticTravel })
        default:
            currentData = cityData.city
        }

        currentData = currentData.filter({
            $0.cityName == nonSpacedKeyword ||
            $0.upperKeyword == nonSpacedKeyword ||
            $0.cityExplain.contains(nonSpacedKeyword)
        })

        countryTableView.reloadData()
    }

    @IBAction func textFieldEditChanged(_ sender: UITextField) {
        guard let keyword = sender.text?.uppercased(),
              !keyword.isEmpty else {
            return
        }

        if sender.text == "" {
            segmentedTapped(segMenu)
        }

        let attributedKeyword = NSMutableAttributedString(string: keyword)

        let krKeywordArr = cityData.city.map { $0.cityName }
        let enKeywordArr = cityData.city.map { $0.upperKeyword }
        let explainKeywordArr = cityData.city.map { $0.cityExplain }



//        if krKeywordArr.contains(where: {
//            $0.contains(keyword)
//        }) {
//            let keywordRange = (keyword as NSString).range(of: keyword)
//            attributedKeyword.addAttributes([
//                .foregroundColor: UIColor.brown
//            ], range: keywordRange)
//            sender.attributedText = attributedKeyword
//        } else {
//            let nonKeywordRange = (keyword as NSString).range(of: keyword)
//            attributedKeyword.addAttributes([
//                .foregroundColor: UIColor.black
//            ], range: nonKeywordRange)
//            sender.attributedText = attributedKeyword
//        }

        // 이거 어떻게 split해서 앞에거만 살리지
        if krKeywordArr.contains(where: { $0 == keyword }) ||
            enKeywordArr.contains(where: { $0 == keyword }) ||
            explainKeywordArr.contains(where: { $0.contains(keyword) })
        {
            let keywordRange = (keyword as NSString).range(of: keyword)
            attributedKeyword.addAttributes([
                .foregroundColor: UIColor.brown
            ], range: keywordRange)
            sender.attributedText = attributedKeyword
        } else {
            let nonKeywordRange = (keyword as NSString).range(of: keyword)
            attributedKeyword.addAttributes([
                .foregroundColor: UIColor.black
            ], range: nonKeywordRange)
            sender.attributedText = attributedKeyword
        }
    }
    

}
