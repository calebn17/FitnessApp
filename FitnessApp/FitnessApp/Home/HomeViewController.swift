//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

final class HomeViewController: UIViewController {
    
//MARK: - Properties
    weak var coordinator: HomeCoordinator?
    private let viewModel = HomeViewModel()
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        handleIsAuthenticated()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func handleIsAuthenticated() {
        if viewModel.isNotAuthenticated {
            coordinator?.presentLogin(sender: self)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath)
        let colors: [UIColor] = [.red, .blue, .systemPink, .purple, .cyan]
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
}
extension HomeViewController {
    private func configureCollectionView() {
        let sectionHeight: CGFloat = 380
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { index, _ in
                //Item
                let ownerItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(60)
                    )
                )
                let postItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(200)
                    )
                )
                let actionsItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
                let likesItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
                let timeItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
                
                //Group
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(sectionHeight)
                    ),
                    subitems: [
                        ownerItem,
                        postItem,
                        actionsItem,
                        likesItem,
                        timeItem
                    ]
                )
                
                //Section
                let section = NSCollectionLayoutSection(group: group)
                //adding some padding
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
                return section
            })
        )
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(OwnerPostCollectionViewCell.self, forCellWithReuseIdentifier: OwnerPostCollectionViewCell.identifier)
        collectionView.register(PostPostCollectionViewCell.self, forCellWithReuseIdentifier: PostPostCollectionViewCell.identifier)
        collectionView.register(ActionsPostCollectionViewCell.self, forCellWithReuseIdentifier: ActionsPostCollectionViewCell.identifier)
        collectionView.register(LikesPostCollectionViewCell.self, forCellWithReuseIdentifier: LikesPostCollectionViewCell.identifier)
        collectionView.register(TimePostCollectionViewCell.self, forCellWithReuseIdentifier: TimePostCollectionViewCell.identifier)
        self.collectionView = collectionView
    }
}
