//
//  EventsController.swift
//  FRSeatGeek
//
//  Created by Lambda_School_Loaner_204 on 3/2/21.
//

import Foundation
import CoreData

class EventsController {

    private let baseURL = URL(string: "https://api.seatgeek.com/2/events")!
    private let clientID = "MjE1Njc2NTV8MTYxNDcwNTg3OC4wNjIwMDg0"

    var events = [EventRepresentation]()

    init() {
        fetchEvents()
    }

    private func fetchEvents(completion: @escaping (Error?) -> Void = { _ in }) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: clientID)
        ]

        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                print("Error fetching events: \(error)")
                completion(error)
                return
            }

            guard let data = data else {
                print("No data returned by event")
                completion(NSError())
                return
            }

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedEvents = try jsonDecoder.decode(EventResults.self, from: data)
                self.events.append(contentsOf: decodedEvents.events)
                completion(nil)
            } catch {
                print("Error decoding event representation: \(error)")
                completion(error)
                return
            }
        }.resume()
    }

    func performSearch(search: String, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: search),
            URLQueryItem(name: "client_id", value: clientID)
        ]

        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                print("Error fetching events: \(error)")
                completion(error)
                return
            }

            guard let data = data else {
                print("No data returned by event")
                completion(NSError())
                return
            }

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedEvents = try jsonDecoder.decode(EventResults.self, from: data)
                self.events.append(contentsOf: decodedEvents.events)
                completion(nil)
            } catch {
                print("Error decoding event representation: \(error)")
                completion(error)
                return
            }
        }.resume()
    }

    func updateWithFavorites(id: String) -> Bool {
        var isFavorite = false
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.performAndWait {
            do {
                let existingEvents = try context.fetch(fetchRequest)
                for event in existingEvents {
                    if let eventID = event.id {
                        if id == eventID {
                            isFavorite = true
                        }
                    }
                }
            } catch {
                print("Error fetching entries for IDs: \(error)")
            }
        }
        return isFavorite
    }

    func favoriteEvent(favorite: Bool, id: String) {
        let event = Event(context: CoreDataStack.shared.mainContext)
        event.id = id
        event.favorite = favorite
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("Error saving object \(error)")
        }
    }

    func deleteFavoriteEventByID(id: String) {

        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.performAndWait {
            do {
                let existingEvents = try context.fetch(fetchRequest)
                for event in existingEvents {
                    if let eventID = event.id {
                        if id == eventID {
                            context.delete(event)
                            try CoreDataStack.shared.save(context: context)
                        }
                    }
                }
            } catch {
                context.reset()
                print("Error deleting event with ID: \(error)")
            }
        }
    }
}
