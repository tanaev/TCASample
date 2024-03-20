import Foundation
import SwiftUI

struct SliderView: View {
    
    @Binding var currentValue: Double
    var height: CGFloat = 4
    let thumbWidth = 16.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                let centerYPoint = geometry.size.height / 2
                
                Capsule()
                    .foregroundColor(Color(.secondary))
                    .frame(height: height)
                if currentValue > 0 {
                    Capsule()
                        .foregroundColor(Color(.accent))
                        .frame(width: geometry.size.width * currentValue, height: height, alignment: .leading)
                        .alignmentGuide(.leading) { _ in 0 }
                }
                let currentXPositionOfPicker: CGFloat =
                geometry.size.width * CGFloat(currentValue)
                let normalizedPosX = min(
                    geometry.size.width - thumbWidth / 2,
                    max(thumbWidth / 2, currentXPositionOfPicker)
                )
                Circle()
                    .foregroundColor(Color(.accent))
                    .frame(width: thumbWidth, height: thumbWidth)
                    .position(
                        x: normalizedPosX,
                        y: centerYPoint
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ (value) in
                                let activeWidth = geometry.size.width - thumbWidth
                                let pointX =
                                min(
                                    geometry.size.width - thumbWidth,
                                    max(0, value.location.x - thumbWidth / 2)
                                )
                                currentValue = pointX / activeWidth
                            })
                    )
            }
            .onTapGesture { location in
                let activeWidth = geometry.size.width - thumbWidth
                let pointX =
                min(
                    geometry.size.width - thumbWidth,
                    max(0, location.x - thumbWidth / 2)
                )
                currentValue = pointX / activeWidth
            }
        }
        .frame(height: height)
    }
}

#Preview {
    @State var percentage: Double = 0.5
    return SliderView(currentValue: $percentage)
}
