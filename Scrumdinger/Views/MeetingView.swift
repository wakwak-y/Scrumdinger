//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Yu Wakui on 2024/06/08.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            // ProgressView for the meeting progress
            ProgressView(value: 5.0, total: 15.0)
            
            // Display elapsed and remaining time
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining")
            .accessibilityValue("10 minutes")
            
            // Circle to represent meeting progress visually
            Circle()
                .strokeBorder(lineWidth: 24.0)
            
            // Display current speaker and button for next speaker
            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button {} label: {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Mext speaker")
            }
        }
        .padding()
    }
}

#Preview {
    MeetingView()
}
