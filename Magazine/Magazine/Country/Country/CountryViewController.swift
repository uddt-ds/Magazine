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
        guard let userInput = sender.text?.uppercased(),
              !userInput.isEmpty else {
            segmentedTapped(segMenu)
            return
        }

        let nonSpacedKeyword = userInput.trimmingCharacters(in: .whitespaces)

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
        guard let userInput = sender.text?.uppercased(),
              !userInput.isEmpty else {
            return
        }

        if sender.text == "" {
            segmentedTapped(segMenu)
        }

        let attributedKeyword = NSMutableAttributedString(string: userInput)
        print(attributedKeyword)

        let krKeywordArr = cityData.city.map { $0.cityName }
        let enKeywordArr = cityData.city.map { $0.upperKeyword }
        let rawExplainKeywordArr = cityData.city.map { $0.cityExplain }

        // TODO: components(separatedBy:) 찾아보기
        let explainArrData = rawExplainKeywordArr.map {
            $0.split(separator: ",")
        }

        print(rawExplainKeywordArr)

        var explainKeyword = [String]()

        for data in explainArrData {
            for keyword in data {
                explainKeyword.append(String(keyword.trimmingCharacters(in: .whitespaces)))
            }
        }

        let totalKeywords = krKeywordArr + enKeywordArr + explainKeyword

        for word in totalKeywords {
            if let range = userInput.range(of: word) {
                print("range: \(range)")
                let nsRange = NSRange(range, in: userInput)
                print("NSRange: \(nsRange)")
                attributedKeyword.addAttribute(.foregroundColor, value: UIColor.brown, range: nsRange)
            }
        }

        sender.attributedText = attributedKeyword



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

        // TODO: 주어진 단어를 배열에 저장하고, 작성된 글자를 조합해서 반복문(돌려서 적용..)
        // 한칸짜리 탐색 -> 두글자짜리 탐색
        // 텍스트 길이 받아오고(텍스트 길이만큼 반복), 글자별로 딕셔너리 만들고 돌리는 방법 (고민)
        // 트리 구조: trie 자료구조(찾아보기 - 시간복잡도 관련 keyword)
//        if krKeywordArr.contains(where: { $0 == keyword }) ||
//            enKeywordArr.contains(where: { $0 == keyword }) ||
//            explainKeywordArr.contains(where: { $0.contains(keyword) })
//        {
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
    }
    

}
