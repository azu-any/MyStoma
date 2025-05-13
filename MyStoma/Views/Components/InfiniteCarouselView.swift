import SwiftUI

struct InfiniteCarouselView: View {
    let images = ["StomaBag", "StomaBag2", "StomaBag3", "StomaBag4"]
    let spacing: CGFloat = 5
    let imageWidth: CGFloat = 100
    let speed: CGFloat = 100

    @State private var scrollOffset: CGFloat = 0
    @State private var timer: Timer?
    @State private var toggleRotation: Bool = false
    @State private var timeCounter: Double = 0
    @State private var yOffsets: [CGFloat] = []

    var body: some View {
        GeometryReader { geo in
            let visibleWidth = geo.size.width
            let singleSetWidth = CGFloat(images.count) * (imageWidth + spacing)
            let repeatCount = Int(ceil((visibleWidth * 2) / singleSetWidth))
            let totalImageCount = images.count * repeatCount

            HStack(spacing: spacing) {
                ForEach(0 ..< totalImageCount, id: \.self) { index in
                    Image(images[index % images.count])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageWidth, height: 150)
                        .rotationEffect(.degrees(toggleRotation ? 45 : -45))
                        .animation(.none, value: toggleRotation)
                        .offset(y: yOffsets.indices.contains(index) ? yOffsets[index] : 0)
                }
            }
            .offset(x: -scrollOffset)
            .onAppear {
                generateRandomOffsets(count: totalImageCount)
                startTimer(totalWidth: singleSetWidth * CGFloat(repeatCount))
            }
            .onDisappear {
                stopTimer()
            }
        }
        .frame(height: 150)
        .clipped()
    }

    private func generateRandomOffsets(count: Int) {
        yOffsets = (0 ..< count).map { _ in CGFloat(Int.random(in: -5 ... 5)) }
    }

    private func startTimer(totalWidth: CGFloat) {
        timer = Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true) { _ in
            scrollOffset += speed / 60

            if scrollOffset >= totalWidth {
                scrollOffset = 0
            }

            timeCounter += 1 / 60
            if timeCounter >= 1 {
                toggleRotation.toggle()
                timeCounter = 0
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
