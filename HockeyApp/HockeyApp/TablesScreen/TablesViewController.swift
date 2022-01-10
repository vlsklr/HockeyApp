//
//  TablesViewController.swift
//  HockeyApp
//
//  Created by Vlad on 20.11.2021.
//

import Foundation
import UIKit

protocol ITablesViewController: AnyObject {
    
}

class TablesViewController: UIViewController, ITablesViewController {
    let presenter: ITablesPresenter
    let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let rowsCount = 11
    
    init(presenter: ITablesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.backgroundColor = .red
        setupCollectionView()
       
    }
    
    func setupCollectionView() {
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TablesCell.self, forCellWithReuseIdentifier: "teamCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(125)
            make.bottom.equalToSuperview().offset(-125)
        }
    }
}

extension TablesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TablesCell
        presenter.setupCell(teamCell: cell, for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.bounds.height - 250
        if indexPath.row == 1 {
            return CGSize(width: 300, height: height)
        }
        if indexPath.row == (rowsCount - 2) || indexPath.row == 0 {
            return CGSize(width: 100, height: height)
        }
        return CGSize(width: 75, height: height)
    }
}

