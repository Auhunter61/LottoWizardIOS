import Foundation

enum LottoWizardConfig {
    static let startURL = URL(string: "https://lottowizard.net/mobile-app/?shell=1&native=ios")

    static var isConfigured: Bool {
        guard let absolute = startURL?.absoluteString else {
            return false
        }
        return !absolute.contains("your-domain.example")
    }
}
