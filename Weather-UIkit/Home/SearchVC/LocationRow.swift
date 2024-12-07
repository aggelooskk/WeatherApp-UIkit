//
//  LocationRow.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 7/12/24.
//

import UIKit

class LocationRow: UITableViewCell {
    static let id = "LocationRow"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
