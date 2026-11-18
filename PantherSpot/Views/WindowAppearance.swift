import SwiftUI

struct WindowAppearance: UIViewRepresentable {
    let appearance: AppAppearance

    func makeUIView(context: Context) -> StyleView {
        let view = StyleView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.style = appearance.interfaceStyle
        return view
    }

    func updateUIView(_ view: StyleView, context: Context) {
        view.style = appearance.interfaceStyle
    }

    final class StyleView: UIView {
        var style: UIUserInterfaceStyle = .unspecified {
            didSet { applyStyle() }
        }

        override func didMoveToWindow() {
            super.didMoveToWindow()
            applyStyle()
        }

        private func applyStyle() {
            guard let window, window.overrideUserInterfaceStyle != style else { return }
            // Update the whole window so open sheets follow System, Light, or Dark too.
            window.overrideUserInterfaceStyle = style
        }
    }
}
