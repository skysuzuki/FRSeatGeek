//
//  DetailEventViewController.swift
//  FRSeatGeek
//
//  Created by Lambda_School_Loaner_204 on 3/2/21.
//

import UIKit

class DetailEventViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!

    var event: EventRepresentation?
    var favorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func favoriteDidTap(sender: UIBarButtonItem) {
        if favorite {
            favoriteButtonItem.image = UIImage(systemName: "heart")
        } else {
            favoriteButtonItem.image = UIImage(systemName: "heart.fill")
        }
        favorite.toggle()
    }
    

    private func updateViews() {
        guard let event = event else { return }

        // Setting the navigation title text
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .black
        label.text = event.title
        self.navigationItem.titleView = label


        dateLabel.text = event.datetimeLocal

    }
}
