//
//  ImageCell.swift
//  Usher
//
//  Created by Mac Compus on 3/14/16.
//  Copyright © 2016 Mac Compus. All rights reserved.
//

import UIKit
import Photos

class ImageCell: UICollectionViewCell {
    
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        contentView.addSubview(imageView)
        
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "ALPlaceholder", inBundle: CameraGlobals.shared.bundle, compatibleWithTraitCollection: nil)
    }
    
    func configureWithModel(model: PHAsset) {
        
        imageView.image = UIImage(named: "ALPlaceholder", inBundle: CameraGlobals.shared.bundle, compatibleWithTraitCollection: nil)
        
        if tag != 0 {
            PHImageManager.defaultManager().cancelImageRequest(PHImageRequestID(tag))
        }
        
        var thumbnailSize = CameraGlobals.shared.photoLibraryThumbnailSize
        thumbnailSize.width *= scale
        thumbnailSize.height *= scale
        
        tag = Int(PHImageManager.defaultManager().requestImageForAsset(model, targetSize: thumbnailSize, contentMode: .AspectFill, options: nil) { image, info in
            self.imageView.image = image
        })
    }
}
