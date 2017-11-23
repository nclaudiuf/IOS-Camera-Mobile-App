//
//  LibraryManager.swift
//  Usher
//
//  Created by Mac Compus on 3/14/16.
//  Copyright © 2016 Mac Compus. All rights reserved.
//

import UIKit
import Photos

internal let ImageCellIdentifier = "ImageCell"

internal let defaultItemSpacing: CGFloat = 1

typealias LibraryManagerSelectionComplete = (asset: PHAsset?) -> Void

internal class LibraryManager: UIViewController {
    
    internal var onSelectionComplete: LibraryManagerSelectionComplete?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CameraGlobals.shared.photoLibraryThumbnailSize
        layout.minimumInteritemSpacing = defaultItemSpacing
        layout.minimumLineSpacing = defaultItemSpacing
        layout.sectionInset = UIEdgeInsetsZero
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
    private var assets: PHFetchResult!
    
    internal override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.clearColor()
        
        ImageFetcher()
            .onFailure(onFailure)
            .onSuccess(onSuccess)
            .fetch()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.userInteractionEnabled = true
    }
    
    internal override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.frame
    }
    
    internal func dismiss() {
        onSelectionComplete?(asset: nil)
    }
    
    private func onSuccess(photos: PHFetchResult) {
        assets = photos
        configureCollectionView()
    }
    
    private func onFailure(error: NSError) {
        let permissionsView = PermissionsView(frame: view.bounds)
        permissionsView.titleLabel.text = LocalizedString("permissions.library.title")
        permissionsView.descriptionLabel.text = LocalizedString("permissions.library.description")
        
        view.addSubview(permissionsView)
    }
    
    private func configureCollectionView() {
        collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: ImageCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> PHAsset {
        return assets[indexPath.row] as! PHAsset
    }
}

// MARK: - UICollectionViewDataSource -
extension LibraryManager : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let model = itemAtIndexPath(indexPath)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCellIdentifier, forIndexPath: indexPath) as! ImageCell
        
        cell.configureWithModel(model)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate -
extension LibraryManager : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let asset = itemAtIndexPath(indexPath)
        onSelectionComplete?(asset: asset)
    }
}
