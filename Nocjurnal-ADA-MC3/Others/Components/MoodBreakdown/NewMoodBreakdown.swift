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
    @State var currentPositions: [CGPoint] = []
    
    private let containerSize: CGSize = CGSize(width: 350, height: 250)
    
    var body: some View {
        ZStack {
            ForEach(0..<circles.count, id: \.self) { index in
                Mood(mood: circles[index])
                    .frame(width: circles[index].radius * 2, height: circles[index].radius * 2)
                    .position(currentPositions[index])
            }
        }
        .frame(width: containerSize.width, height: containerSize.height)
        .onAppear {
            generateCircles()
        }
        .onChange(of: targetPositions){
            for (index,_) in circles.enumerated(){
                withAnimation(.spring(duration:2)){
                    
                    currentPositions[index].x = targetPositions[index].x
                    currentPositions[index].y = targetPositions[index].y
                    
                }
            }
        }
    }
    
    private func generateCircles() {
        let moodCluster = MoodCluster(moods: [MoodData(mood: "Sad", percentage: 50)])
        moodCluster.generateTempData()
        var newCircles : [MoodData] = []
        let Moods = moodCluster.moods
        
        for mood in Moods{
            let newCircle = mood
            currentPositions.append(mood.position)
            getTargetPosition(mood: mood, newCircle: newCircle, newCircles: newCircles)
            
            newCircles.append(newCircle)
            
            circles = newCircles
            
        }
    }
    
    func getTargetPosition(mood: MoodData, newCircle: MoodData, newCircles: [MoodData]){
        var x: CGFloat = 0
        var y: CGFloat = 0
        repeat {
            let radius = CGFloat(mood.percentage * 3 / 4 + 10)
            
            x = CGFloat.random(in: radius...(containerSize.width - radius))
            y = CGFloat.random(in: radius...(containerSize.height - radius))
            newCircle.setPosition(position: CGPoint(x:x, y:y))
        } while doesOverlap(newCircle, with: newCircles)
        targetPositions.append(CGPoint(x: x, y: y))
    }
    
    private func doesOverlap(_ circle: MoodData, with circles: [MoodData]) -> Bool {
        for (index, otherCircle) in circles.enumerated() {
            let distance = sqrt(pow(circle.position.x - targetPositions[index].x, 2) +
                                pow(circle.position.y - targetPositions[index].y, 2))
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




