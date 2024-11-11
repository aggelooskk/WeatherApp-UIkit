//
//  HomeTopRow.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 10/11/24.
//

import UIKit

class HomeTopRow: UITableViewCell {
    static let id = "HomeTopRow"
    
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var highlowLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func configure() {
        
    }

}
