//
//  CountryCallingCodeCell.swift
//
//  Created by Muhammad Imran on 02/12/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

open class CountryCallingCodeCell: UITableViewCell {
    
    let flag = UILabel()
    let CountryName = UILabel()
    let CountryCallingCode = UILabel()
    let stackView = UIStackView()
    public  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(flag)
        addSubview(CountryName)
        addSubview(CountryCallingCode)
        
        CountryName.numberOfLines = 0
        
        flag.translatesAutoresizingMaskIntoConstraints = false
        CountryName.translatesAutoresizingMaskIntoConstraints = false
        CountryCallingCode.translatesAutoresizingMaskIntoConstraints = false
        
        flag.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        flag.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        flag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        flag.widthAnchor.constraint(equalToConstant: 32).isActive = true
        flag.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        CountryName.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        CountryName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        CountryName.leadingAnchor.constraint(equalTo: flag.trailingAnchor, constant: 0).isActive = true
        CountryName.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        
        CountryCallingCode.topAnchor.constraint(equalTo: topAnchor , constant: 5).isActive = true
        CountryCallingCode.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        CountryCallingCode.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
      
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


