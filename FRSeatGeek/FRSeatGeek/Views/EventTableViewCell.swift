//
//  EventTableViewCell.swift
//  FRSeatGeek
//
//  Created by Lambda_School_Loaner_204 on 3/2/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!

    var isFavorite: Bool? {
        didSet {
            updateViews()
        }
    }


    private func updateViews() {

        guard let isFavorite = isFavorite else {
            favoriteImage.image = nil
            return
        }

        if isFavorite {
            favoriteImage.image = UIImage(systemName: "heart.fill")?.withTintColor(.red)
        } else {
            favoriteImage.image = nil
        }
    }
}
