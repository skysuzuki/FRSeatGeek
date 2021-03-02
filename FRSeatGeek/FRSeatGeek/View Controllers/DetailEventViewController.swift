//
//  DetailEventViewController.swift
//  FRSeatGeek
//
//  Created by Lambda_School_Loaner_204 on 3/2/21.
//

import UIKit

class DetailEventViewController: UIViewController {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!

    var event: EventRepresentation?
    var eventController: EventsController?
    var favorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func favoriteDidTap(sender: UIBarButtonItem) {
        guard let eventController = eventController,
              let event = event else { return }
        let id = String(event.id)
        if favorite {
            favoriteButtonItem.image = UIImage(systemName: "heart")
            eventController.deleteFavoriteEventByID(id: id)
        } else {
            favoriteButtonItem.image = UIImage(systemName: "heart.fill")
            eventController.favoriteEvent(favorite: favorite, id: id)
        }
        favorite.toggle()
    }
    

    private func updateViews() {
        guard let eventController = eventController,
              let event = event else { return }

        favorite = eventController.updateWithFavorites(id: String(event.id))
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
        locationLabel.text = "\(event.venue.city), \(event.venue.state)"
        eventImage.download(from: event.performers[0].image)

        if favorite {
            favoriteButtonItem.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButtonItem.image = UIImage(systemName: "heart")
        }
    }
}
