//
//  ImagesHelper.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/4/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class ImagesHelper {
    
    internal static func applyIOSMask(imageView: UIImageView) {
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor(white: 0.9, alpha: 1).CGColor
        imageView.layer.cornerRadius = 13
        imageView.layer.masksToBounds = true
        imageView.alpha = 0
    }
    
}