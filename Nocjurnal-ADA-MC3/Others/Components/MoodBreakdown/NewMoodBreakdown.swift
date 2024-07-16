//
//  MoodPositioning.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 15/07/24.
//

import SwiftUI


struct MoodBreakDown: View {
    @State private var circles: [MoodData] = []
    @State var targetPositions: [CGPoint] = []
    private let containerSize: CGSize = CGSize(width: 350, height: 350)
    
    var body: some View {
        ZStack {
            ForEach(0..<circles.count, id: \.self) { index in
                Mood(mood: circles[index])
                    .frame(width: circles[index].radius * 2, height: circles[index].radius * 2)
                    .position(circles[index].position)
            }
        }
        .frame(width: containerSize.width, height: containerSize.height)
        .onAppear {
            generateCircles()
        }
    }
    
    private func generateCircles() {
        let moodCluster = MoodCluster(moods: [MoodData(color: .blue, mood: "Sad", percentage: 50)])
        moodCluster.generateTempData()
        var newCircles : [MoodData] = []
        let Moods = moodCluster.moods
        
        for mood in Moods{
            var newCircle = mood
            let radius = CGFloat(mood.percentage * 3 / 4 + 30)
            
            // move to the right spot
            newCircle = moveCircles(mood: mood, newCircle: newCircle, newCircles: newCircles)
            
            newCircles.append(newCircle)
            
            circles = newCircles
            
//getTargetPosition(mood: mood, newCircle: newCircle, newCircles: newCircles)
            
        }
    }
    
    func getTargetPosition(mood: MoodData, newCircle: MoodData, newCircles: [MoodData]){
        let x: CGFloat = 0
        let y: CGFloat = 0
        repeat {
            let radius = CGFloat(mood.percentage * 3 / 4 + 30)
            
            let x = CGFloat.random(in: radius...(containerSize.width - radius))
            let y = CGFloat.random(in: radius...(containerSize.height - radius))
            newCircle.setPosition(position: CGPoint(x:x, y:y))
        } while doesOverlap(newCircle, with: newCircles)
        
        targetPositions.append(CGPoint(x: x, y: y))
        print(targetPositions)
    }
    
    private func moveCircles(mood: MoodData, newCircle: MoodData, newCircles: [MoodData]) -> MoodData{
        repeat {
            let radius = CGFloat(mood.percentage * 3 / 4 + 30)
            
            let x = CGFloat.random(in: radius...(containerSize.width - radius))
            let y = CGFloat.random(in: radius...(containerSize.height - radius))
            newCircle.setPosition(position: CGPoint(x:x, y:y))
        } while doesOverlap(newCircle, with: newCircles)
        
        return mood
    }
    
    private func doesOverlap(_ circle: MoodData, with circles: [MoodData]) -> Bool {
        for otherCircle in circles {
            let distance = sqrt(pow(circle.position.x - otherCircle.position.x, 2) +
                                pow(circle.position.y - otherCircle.position.y, 2))
            if distance < circle.radius + otherCircle.radius {
                return true
            }
        }
        return false
    }
    
}

#Preview {
    MoodBreakDown()
}




