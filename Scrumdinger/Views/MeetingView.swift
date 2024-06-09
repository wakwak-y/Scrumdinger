//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Yu Wakui on 2024/06/08.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining,
                                  theme: scrum.theme)
                
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
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
