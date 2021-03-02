//
//  EventTableViewCell.swift
//  FRSeatGeek
//
//  Created by Lambda_School_Loaner_204 on 3/2/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleText: UILabel!
    @IBOutlet private weak var date: UILabel!

    var eventRepresentation: EventRepresentation? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let event = eventRepresentation else { return }

        titleText.text = event.title
        date.text = event.datetimeLocal
    }

}
