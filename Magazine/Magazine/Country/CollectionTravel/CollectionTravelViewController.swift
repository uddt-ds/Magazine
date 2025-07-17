//
//  CollectionTravelViewController.swift
//  Magazine
//
//  Created by Lee on 7/17/25.
//

import UIKit

final class CollectionTravelViewController: UIViewController {

    @IBOutlet var segMenu: UISegmentedControl!

    @IBOutlet var travelCollectionView: UICollectionView!

    @IBOutlet var searchTextField: UITextField!

    let cityManager = CityManager()

    var weight: CGFloat = 0

    let totalData = CityInfo().city
    var data = CityInfo().city

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.isTabBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegMenu()
        setupNavigation()

        let xib = UINib(nibName: String(describing: CollectionViewTravelCell.self), bundle: nil)

        travelCollectionView.register(xib, forCellWithReuseIdentifier: String(describing: CollectionViewTravelCell.self))

        travelCollectionView.delegate = self
        travelCollectionView.dataSource = self
        travelCollectionView.collectionViewLayout = setupLayout()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.isTabBarHidden = false
    }

    private func setupNavigation() {
        let image = UIImage(systemName: "xmark")
        navigationItem.title = "인기 도시"
        navigationController?.navigationBar.scrollEdgeAppearance = .init()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    private func setupSegMenu() {
        segMenu.selectedSegmentIndex = 0
        segMenu.setTitle(SegCase.total.title,
                         forSegmentAt: SegCase.total.rawValue)
        segMenu.setTitle(SegCase.domestic.title,
                         forSegmentAt: SegCase.domestic.rawValue)
        segMenu.insertSegment(withTitle: SegCase.oversea.title,
                              at: SegCase.oversea.rawValue, animated: true)
        segMenu.tintColor = .black
    }

    private func setupLayout() -> UICollectionViewFlowLayout {
        let deviceWidth = UIScreen.main.bounds.width
//        let deviceHeight = UIScreen.main.bounds.height
        let inset = CollectionFigure.inset.figure
        let spacing = CollectionFigure.spacing.figure
        let itemCount = CollectionFigure.itemCount.figure
//        let segment = CollectionFigure.seg.figure
//        let scenes = UIApplication.shared.connectedScenes
//        var safeArea: (CGFloat, CGFloat) = (0, 0)
//        let windowScene = scenes.first as? UIWindowScene
//        if let hasWindosScene = windowScene {
//            safeArea.0 = hasWindosScene.windows.first?.safeAreaInsets.top ?? 0
//            safeArea.1 = hasWindosScene.windows.first?.safeAreaInsets.bottom ?? 0
//        }
//
        let cellWidth = deviceWidth - (inset * 2) - (spacing * (itemCount - 1))
//        let cellHeight = Int(deviceHeight) - (inset * 0) - (spacing * (itemCount + 1)) - segment - Int(safeArea.0) - Int(safeArea.1)
//

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth/itemCount, height: cellWidth * 1.4/itemCount)
        print(cellWidth * 1.4)
        print(cellWidth)

        weight = cellWidth/itemCount

        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(inset), bottom: 0, right: CGFloat(inset))
        layout.minimumInteritemSpacing = CGFloat(spacing)
        layout.minimumLineSpacing = CGFloat(spacing)
        layout.scrollDirection = .vertical

        return layout
    }

    @objc
    func leftButtonTapped(_ sender: UIBarButtonItem) {
        print(#function)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: String(describing: MagazineTableViewController.self))
        //TODO: overFullScreen, overCurrentContext 차이 확인해보기
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }


    @IBAction func segmentedTapped(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case SegCase.total.rawValue:
            data = totalData
        case SegCase.domestic.rawValue:
            data = cityManager.domesticData
        case SegCase.oversea.rawValue:
            data = cityManager.overseaData
        default:
            return
        }
        travelCollectionView.reloadData()
    }

    @IBAction func textFieldEndExit(_ sender: UITextField) {
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let userInput = sender.text else {
            return
        }

        let nonSpacedKeyword = userInput.trimmingCharacters(in: .whitespaces)
        let upperKeyword = nonSpacedKeyword.uppercased()

        switch segMenu.selectedSegmentIndex {
        case SegCase.total.rawValue:
            data = totalData
        case SegCase.domestic.rawValue:
            data = cityManager.domesticData
        case SegCase.oversea.rawValue:
            data = cityManager.overseaData
        default:
            return
        }

        data = data.filter({
            $0.cityName == nonSpacedKeyword ||
            $0.cityEnglishName == nonSpacedKeyword ||
            $0.upperKeyword == upperKeyword ||
            $0.cityExplain.contains(nonSpacedKeyword)
        })

        if sender.text == "" {
            segmentedTapped(segMenu)
        }

        travelCollectionView.reloadData()
    }
    

}

extension CollectionTravelViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewTravelCell.self), for: indexPath) as? CollectionViewTravelCell else { return .init() }
        cell.configureCell(with: data[indexPath.item])
        cell.configureImage(with: CGFloat(weight) / 2)
        cell.configureLabel(keyword: searchTextField.text ?? "")
        return cell
    }
}

enum SegCase: Int {
    case total = 0
    case domestic
    case oversea

    var title: String {
        switch self {
        case .total: return "모두"
        case .domestic: return "국내"
        case .oversea: return "해외"
        }
    }
}

enum CollectionFigure {
    case inset
    case spacing
    case itemCount
    case seg

    var figure: CGFloat {
        switch self {
        case .inset: return 16
        case .spacing: return 16
        case .itemCount: return 2
        case .seg: return 32
        }
    }
}
