import SwiftUI

struct LaunchIntroView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 20) {
            Image("LaunchMark")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .accessibilityHidden(true)
                .scaleEffect(reduceMotion || appeared ? 1 : 0.9)

            Text("PantherSpot")
                .font(.largeTitle.bold())
            Text("Find your focus.")
                .font(.headline)
                .foregroundStyle(Color.accentColor)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LaunchBackground").ignoresSafeArea())
        .onAppear {
            withAnimation(reduceMotion ? nil : .easeOut(duration: 0.6)) {
                appeared = true
            }
        }
    }
}

#Preview {
    LaunchIntroView()
}
