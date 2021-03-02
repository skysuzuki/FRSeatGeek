//
//  EventRepresentation.swift
//  FRSeatGeek
//
//  Created by Lambda_School_Loaner_204 on 3/2/21.
//

import Foundation

struct EventRepresentation: Decodable {
    var title: String
    var datetimeLocal: String
    // Add if time
    //var performers: Performer
    var id: Int

}

struct EventResults: Decodable {
    var events: [EventRepresentation]
}
