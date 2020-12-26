//
//  PersonDetailViewController.swift
//  TheMovieApp
//
//  Created by ilhan sarı on 22.11.2020.
//  Copyright © 2020 ilhan sarı. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PersonDetailViewController: UIViewController {

  // MARK: view as a `Layoutable`
  private var layoutableView: PersonDetailView {
    guard let personDetailView = view as? PersonDetailView else {
      fatalError("view property has not been initialized yet, or not initialized as PersonDetailView.")
    }
    return personDetailView
  }

  // MARK: Properties
  private var personId: Int
  private var networkManager: NetworkManager
  private var castsModel = [CastDetail]()
  private var castDetailListViewModel: CastDetailListViewModel!
  private var personDetailViewModel: PersonDetailViewModel!

  private let disposeBag = DisposeBag()

  override func loadView() {
    view = PersonDetailView()
  }

  init(personId: Int, networkManager: NetworkManager) {
    self.personId = personId
    self.networkManager = networkManager
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()

  }
}

// MARK: Setup View
extension PersonDetailViewController {
  private func setupView() {
    personDetailViewModel = PersonDetailViewModel(networkManager: networkManager, personId: personId)
    castDetailListViewModel = CastDetailListViewModel(networkManager: networkManager, personId: personId)

    personDetailViewModel.personDetail.drive(onNext: { [weak self] result in
      self?.layoutableView.configureView(result)
    }).disposed(by: disposeBag)

    personDetailViewModel.isFetching.drive(self.layoutableView.activityIndicator.rx.isAnimating).disposed(by: disposeBag)

    castDetailListViewModel.castDetail.drive(onNext: { [weak self](_) in
      self?.layoutableView.castCollectionView.reloadData()
    }).disposed(by: disposeBag)

    castDetailListViewModel.isFetching.drive(self.layoutableView.activityIndicator.rx.isAnimating).disposed(by: disposeBag)

    castDetailListViewModel.castDetail.map { $0 }.asObservable().bind(to: self.layoutableView.castCollectionView.rx.items(cellIdentifier: "CastCell", cellType: CastCell.self)) { (_, person, cell) in
      cell.configure(model: person)
    }.disposed(by: disposeBag)
  }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension PersonDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: layoutableView.castCollectionView.frame.size.height, height: layoutableView.castCollectionView.frame.size.height)
  }
}
