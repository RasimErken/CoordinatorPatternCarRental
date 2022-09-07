//
//  3.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 31.08.2022.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    static let identifier = "CustomTableViewCell"
    
    let myLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 24.0)
        
        
        label.text = ""
        return label
    }()
    
        let myImage : UIImageView = {
        let image = UIImageView()
        
        return image
    }()
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(myLabel)
         contentView.addSubview(myImage)
     }
    
    override func layoutSubviews() {
        myLabel.frame = CGRect(x: 150, y: 30, width: 250 , height: 100)
        myImage.frame = CGRect(x: 0, y: 25, width: 140 , height: 130)
        myImage.layer.cornerRadius = myImage.bounds.height / 2.0
        myImage.layer.borderWidth = 0.5
        myImage.layer.borderColor = UIColor.gray.cgColor
        myImage.layer.masksToBounds = true
        myImage.contentMode = .scaleAspectFill
        
        
    }
    
    func setupCell(withVehicleData  data : VehicleData ) {
        myLabel.text = data.attributes.name
    }
    
    func setupCellPhoto(withVehiclePhoto data : Included ) {
        myImage.image = UIImage(url: URL(string: data.attributes.url))
    }
    
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    
    
    

}
