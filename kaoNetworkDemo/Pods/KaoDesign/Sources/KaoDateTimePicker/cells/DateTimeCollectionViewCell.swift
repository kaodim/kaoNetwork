//
//  DatesCollectionViewCell.swift
//  KaodimIosDesign
//
//  Created by Ramkrishna Baddi on 11/12/18.
//  Copyright © 2018 Kaodim Sdn Bhd. All rights reserved.
//

import UIKit

class DatesCollectionViewCell: UICollectionViewCell, KaoDateTimePickerHelper {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var layoutConst: NSLayoutConstraint!

    var colorMoney: UIColor = .blue

    var disableCell: Bool = false {
        didSet {
            if self.disableCell {
                self.day.textColor = .lightGray
                self.date.textColor = .lightGray
                self.img.image = nil
                self.money.text = ""
                self.backgroundColor = .white
                self.money.textColor = colorMoney
                layoutConst.constant = -10.0
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.manualLayouting(view: self)
        colorMoney = self.money.textColor
        self.day.formattedString(fontSize: 12.0)
        self.date.formattedString(style: .bold, fontSize: 18.0)
        self.money.formattedString(fontSize: 14.0)
    }

    func isCellSelected(_ flag: Bool) {
        if flag {
            self.backgroundColor = UIColor.kaoColor(KaoColorHex.prussianBlue)
            self.day.textColor = .white
            self.date.textColor = .white
            self.money.textColor = .white
            self.img.image = UIImage.imageFromDesignIos("thWhite")
        } else {
            self.backgroundColor = .white
            self.day.textColor = .black
            self.date.textColor = .black
            self.money.textColor = colorMoney
            self.img.image = UIImage.imageFromDesignIos("th")
        }
    }


    func wrapCell(date: String, money: String? = nil) {
        self.day.text = self.formattedDateFromString(dateString: date, withFormat: "EEEE")
        self.date.text = self.formattedDateFromString(dateString: date, withFormat: "dd")
        self.img.image = UIImage.imageFromDesignIos("th")

        if let currency = money, currency.count > 0 {
            self.money.text = "+RM" + " " + currency
            layoutConst.constant = -20.0
        } else {
            layoutConst.constant = 0.0
        }
    }

}

class TimeCollectionViewCell: UICollectionViewCell, KaoDateTimePickerHelper {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var centerConst: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!

    var colorMoney: UIColor = .blue

    var disableCell: Bool = false {
        didSet {
            if self.disableCell {
                self.time.textColor = .lightGray
                self.img.image = nil
                self.money.text = ""
                self.backgroundColor = .white
                self.money.textColor = colorMoney
                centerConst.constant = 0.00
            }
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        colorMoney = self.money.textColor
        self.layer.manualLayouting(view: self)
        self.time.formattedString(fontSize: 12.0)
        self.time.formattedString(fontSize: 12.0)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.time.text = ""
        self.money.text = ""
    }


    func isCellSelected(_ flag: Bool, money: String) {
        if flag {
            self.backgroundColor = UIColor.kaoColor(KaoColorHex.prussianBlue)
            self.time.textColor = .white
            self.money.textColor = .white
            if money.count > 0 {
                self.img.image = UIImage.imageFromDesignIos("thWhite")
            } else {
                self.img.image = nil
            }
        } else {
            self.backgroundColor = .white
            self.time.textColor = .black
            self.money.textColor = colorMoney
            if money.count > 0 {
                self.img.image = UIImage.imageFromDesignIos("th")
            } else {
                self.img.image = nil
            }
        }
    }

    func wrap(date: String, money: String = "", isSelected: Bool = false) {
        self.time.text = date
        if money.count > 0 {
            self.img.image = isSelected ? UIImage.imageFromDesignIos("thWhite"):
                UIImage.imageFromDesignIos("th")
            self.money.text = "+RM" + " " + money
            centerConst.constant = -10.0
        } else {
            self.money.text = ""
            centerConst.constant = 0.0
            self.img.image = nil
        }
    }

}
