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
        setBackground()

        countryTableView.rowHeight = 200

        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        countryTableView.register(nib, forCellReuseIdentifier: "CountryTableViewCell")

        countryTableView.dataSource = self
        countryTableView.delegate = self

        currentData = cityData.city
    }

    private func setBackground() {
        countryTableView.backgroundColor = .clear
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
        cell.configureLabel(with: searchTextField.text ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "CountryDetailViewController", bundle: nil)

        let vc = sb.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController

        switch segMenu.selectedSegmentIndex {
        case 0:
            vc.data = cityData.city[indexPath.row]
        case 1:
            vc.data = cityData.city.filter({ $0.domesticTravel })[indexPath.row]
        case 2:
            vc.data = cityData.city.filter({ !$0.domesticTravel })[indexPath.row]
        default:
            return
        }

        setupNavigationBar()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
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
//        guard let userInput = sender.text?.uppercased(),
//              !userInput.isEmpty else {
//            segmentedTapped(segMenu)
//            return
//        }
//        let nonSpacedKeyword = userInput.trimmingCharacters(in: .whitespaces)
//
//        switch segMenu.selectedSegmentIndex {
//        case 0:
//            currentData = cityData.city
//        case 1:
//            currentData = cityData.city.filter({ $0.domesticTravel })
//        case 2:
//            currentData = cityData.city.filter({ !$0.domesticTravel })
//        default:
//            currentData = cityData.city
//        }
//
//        currentData = currentData.filter({
//            $0.cityName == nonSpacedKeyword ||
//            $0.upperKeyword == nonSpacedKeyword ||
//            $0.cityExplain.contains(nonSpacedKeyword)
//        })
//
//        countryTableView.reloadData()
    }

    @IBAction func textFieldEditChanged(_ sender: UITextField) {
        guard let userInput = sender.text else {
            return
        }

        //TODO: 원본 값을 가지고 있고, 비교 연산을 소문자로만 비교하는 연산(특정 단어의 index로 접근해서)
        //TODO: 재귀함수..... 탐색을 돌려서 길이에 맞게.... (while문으로 탐색)
        let nonSpacedKeyword = userInput.trimmingCharacters(in: .whitespaces)
        let upperKeyword = nonSpacedKeyword.uppercased()

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
            $0.cityEnglishName == nonSpacedKeyword ||
            $0.upperKeyword == upperKeyword ||
            $0.cityExplain.contains(nonSpacedKeyword)
        })

        if sender.text == "" {
            segmentedTapped(segMenu)
        }

        countryTableView.reloadData()
    }
    

}
