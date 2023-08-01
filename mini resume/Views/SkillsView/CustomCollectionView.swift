//
//  CustomCollectionView.swift
//  mini resume
//
//  Created by Виталий Троицкий on 01.08.2023.
//

import UIKit

final class CustomCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !(__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize)) {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
