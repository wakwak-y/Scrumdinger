//
//  History.swift
//  Scrumdinger
//
//  Created by Yu Wakui on 2024/06/09.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], transcript: String) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
    }
}
