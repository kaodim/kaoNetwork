//
//  SectionHeaderCollectionReusableView.swift
//  Kaodim
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var header: UILabel!
    
    func wrap(header: String) {
        self.header.text = header
    }
}
