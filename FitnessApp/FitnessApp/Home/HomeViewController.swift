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
        configureNavBar()
        fetchData()
        updateUI()
        addActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
//MARK: - Configure
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    private func addActions() {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView?.refreshControl = control
    }
    private func handleIsAuthenticated() {
        if viewModel.isNotAuthenticated {
            coordinator?.presentLogin(sender: self)
        }
    }
    
    private func updateUI() {
        viewModel.posts.bind {[weak self] _ in
            self?.collectionView?.reloadData()
        }
    }
    
//MARK: - Networking
    private func fetchData() {
        Task {
            try await viewModel.fetchPosts()
        }
    }
    
//MARK: - Actions
    @objc private func didTapAddButton() {
        coordinator?.pushAddPostVC(sender: self)
    }
    
    @objc private func didPullToRefresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        fetchData()
        sender.endRefreshing()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.posts.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.value?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellType = viewModel.posts.value?[indexPath.section][indexPath.row] else {return UICollectionViewCell()}
        
        switch cellType{
            
        case .owner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OwnerPostCollectionViewCell.identifier ,for: indexPath)
                    as? OwnerPostCollectionViewCell else {return UICollectionViewCell()}
            
            cell.configure(with: viewModel)
            return cell
            
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostPostCollectionViewCell.identifier ,for: indexPath)
                    as? PostPostCollectionViewCell else {return UICollectionViewCell()}
          
            cell.configure(with: viewModel)
            return cell
            
        case .likes(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesPostCollectionViewCell.identifier ,for: indexPath)
                    as? LikesPostCollectionViewCell else {return UICollectionViewCell()}
          
            cell.configure(with: viewModel)
            return cell
            
        case .timestamp(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimePostCollectionViewCell.identifier ,for: indexPath)
                    as? TimePostCollectionViewCell else {return UICollectionViewCell()}
    
            cell.configure(with: viewModel)
            return cell
            
        case .actions(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionsPostCollectionViewCell.identifier ,for: indexPath)
                    as? ActionsPostCollectionViewCell else {return UICollectionViewCell()}
       
            cell.configure(with: viewModel)
            return cell
        }
    }
}

//MARK: - Configure CollectionView
extension HomeViewController {
    private func configureCollectionView() {
        let sectionHeight: CGFloat = 330
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
                        heightDimension: .absolute(150)
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
                        likesItem,
                        timeItem,
                        actionsItem
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
