//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Yu Wakui on 2024/06/08.
//

import SwiftUI

struct DetailEditView: View {
    @State private var scrum = DailyScrum.emptyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            // Metting info section
            Section(header: Text("Metting Info")) {
                // Text field to edit the scrum title
                TextField("Title", text: $scrum.title)
                // Slider to set the meeting length in minutes
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityLabel("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
            }
            // Attendees section
            Section(header: Text("Attendees")) {
                // List of attendees
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { index in
                    scrum.attendees.remove(atOffsets: index)
                }
                // Text field to add a new attendee
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
