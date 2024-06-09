//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by Yu Wakui on 2024/06/08.
//

import Foundation

// Keeps time for a daily scrum meeting. Keep track of the total meeting time, the time for each speaker, and the name of the current speaker.
@MainActor
final class ScrumTimer: ObservableObject {
    
    // A struct to keep track of meeting attendees during a meeting.
    struct Speaker: Identifiable {
        let id: UUID = UUID()
        let name: String
        var isCompleted: Bool
    }
    
    @Published var activeSpeaker: String = ""
    @Published var secondsElapsed: Int = 0
    @Published var secondsRemaining: Int = 0
    private(set) var speakers: [Speaker] = []
    private(set) var lengthInMinutes: Int
    // A closure that is executed when a new attendee begins speaking.
    var speakerChangedAction: (() -> Void)?
    
    private weak var timer: Timer?
    private var timerStopped: Bool = false
    private var frequency: TimeInterval { 1.0 / 60.0}
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int { (lengthInMinutes * 60) / speakers.count }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String { "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name }
    private var startDate: Date?
    
    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
    
    func startScrum() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }
    
    func stopScrum() {
        timer?.invalidate()
        timerStopped = true
    }
    
    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }
    
    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        
        secondsElapsedForSpeaker = 0
        guard index < speakers.count else { return }
        speakerIndex = index
        activeSpeaker = speakerText
        
        secondsElapsed = index * secondsPerSpeaker
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForSpeaker = secondsElapsed
            self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
            
            guard secondsElapsed <= secondsPerSpeaker else { return }
            
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)
            
            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerChangedAction?()
            }
        }
    }
    
    func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}

extension Array<DailyScrum.Attendee> {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1", isCompleted: false)]
        } else {
            return map { ScrumTimer.Speaker(name: $0.name, isCompleted: false) }
        }
    }
}


