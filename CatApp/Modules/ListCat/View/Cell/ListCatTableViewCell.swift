//
//  ListCatTableViewCell.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import UIKit
import Kingfisher

class ListCatTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var nameCatLabel: UILabel!
    @IBOutlet weak var iconCatImageView: UIImageView!
    @IBOutlet weak var countryCatLabel: UILabel!
    @IBOutlet weak var intelligenceCatLabel: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    // MARK: - Properties
    static let nibName = Constants.Cells.listCatTableViewCell
    static let sizeListCat: CGFloat = Constants.Cells.rowHeightCatListCell
    
    // MARK: Object lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        let borderColorView = UIColor(named: "borderWhite")
        viewContent.layer.borderColor = borderColorView?.cgColor
        viewContent.layer.borderWidth = 2.0
        viewContent.layer.cornerRadius = 20
        viewContent.layer.masksToBounds = true
    }
}
