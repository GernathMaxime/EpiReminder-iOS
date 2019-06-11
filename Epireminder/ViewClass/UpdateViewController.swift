//
//  UpdateViewController.swift
//  Epireminder
//
//  Created by Maxime Gernath on 03/05/2019.
//  Copyright © 2019 MaximeCorp. All rights reserved.
//

import UIKit
import Alamofire
import EventKit
import RealmSwift

class UpdateViewController: UIViewController {

    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func calendarAppButton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "calshow://")! as URL)
    }
    
    @IBAction func updateAgendaButton(_ sender: Any) {
        let parameters: Parameters = [:]
        let user = realm.objects(User.self).first._rlmInferWrappedType()
        let start = "\(Date())".dropLast(15)
        let end = "\(Date().addingTimeInterval(2592000))".dropLast(15)
        Alamofire.request("https://intra.epitech.eu/\(user.autoLog)/planning/load?format=json&start=\(start)&end=\(end)",
                          method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseString { response in
                do {
                    let agenda : Agenda = try JSONDecoder().decode(Agenda.self, from: response.data!)
                    self.updateAgenda(agenda: agenda)
                } catch { print("fail") }
        }
    }

    func updateAgenda(agenda: Agenda) {
        let eventStore = EKEventStore()

        removeAllEventsMatchingPredicate(store: eventStore)
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            agenda.forEach({ (AgendaElement) in
                if ("\(AgendaElement.eventRegistered!)" == "string(\"registered\")") {
                    print("\(AgendaElement.actiTitle!), \(AgendaElement.room?.code ?? ""), \(AgendaElement.start!) -> \(AgendaElement.end!)")
                    let test = AgendaElement.room?.code!.split(separator: "/")
                    print(test!.last!)
                    self.addToCalendar(store: eventStore, title: AgendaElement.actiTitle!, room: String(test!.last!), start: AgendaElement.start!, end: AgendaElement.end!)
                }
            })
        case .denied:
            print("Access denied")
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion:
                {[weak self] (granted: Bool, error: Error?) -> Void in
                    if granted {
                        agenda.forEach({ (AgendaElement) in
                            if ("\(AgendaElement.eventRegistered!)" == "string(\"registered\")") {
                                print("\(AgendaElement.actiTitle!), \(AgendaElement.room?.code ?? ""), \(AgendaElement.start!) -> \(AgendaElement.end!)")
                                let test = AgendaElement.room?.code!.split(separator: "/")
                                print(test!.last!)
                                self!.insertEvent(store: eventStore, title: AgendaElement.actiTitle!, room: String(test!.last!), start: AgendaElement.start!, end: AgendaElement.end!)
                            }
                        })
                    } else {
                        print("Access denied")
                    }
            })
        default:
            print("Case default")
        }
    }

    func addToCalendar(store: EKEventStore, title: String, room: String, start: String, end: String) {
        let calendars = store.calendars(for: .event)
        var exist = false

        for calendar in calendars {
            if calendar.title == "EpiReminder" {
                exist = true
            }
        }
        if exist == false {
            let newCalendar = EKCalendar(for: EKEntityType.event, eventStore: store)
            newCalendar.title = "EpiReminder"
            newCalendar.source = store.defaultCalendarForNewEvents!.source
            do {
                try store.saveCalendar(newCalendar, commit: true)
            } catch { print("Error saving event in calendar") }
        }
        insertEvent(store: store, title: title, room: room, start: start, end: end)
    }

    func insertEvent(store: EKEventStore, title: String, room: String, start: String, end: String) {
        let calendars = store.calendars(for: .event)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startD = formatter.date(from: start)
        let endD = formatter.date(from: end)

        print("add event")
        for calendar in calendars {
            if calendar.title == "EpiReminder" {
                let startDate = startD
                let endDate = endD
                let event = EKEvent(eventStore: store)
                let aInterval: TimeInterval = -1 * 60 * 30
                let alarm = EKAlarm(relativeOffset: aInterval)
                event.calendar = calendar
                event.title = title + " " + room
                event.startDate = startDate
                event.endDate = endDate
                event.alarms = [alarm]
                do {
                    try store.save(event, span: .thisEvent)
                }
                catch { print("Error saving event in calendar") }
            }
        }
    }

    func removeAllEventsMatchingPredicate(store: EKEventStore) {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(2592000)
        let predicate2 = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let eV = store.events(matching: predicate2) as [EKEvent]
        
        print("startDate:\(startDate) endDate:\(endDate)")
        for i in eV {
            if i.calendar.title == "EpiReminder" {
                print("Event detected")
                do {
                    try store.remove(i, span: .thisEvent, commit: true)
                }
                catch { print("Error saving event in calendar") }
            }
        }
    }
}
