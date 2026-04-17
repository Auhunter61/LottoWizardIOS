import Foundation

enum LottoWizardConfig {
    #if DEBUG
    #if targetEnvironment(simulator)
    static let startURL = URL(string: "http://127.0.0.1:8080/mobile-app/?shell=1&native=ios")
    #else
    static let startURL = URL(string: "https://lottowizard.net/mobile-app/?shell=1&native=ios")
    #endif
    #else
    static let startURL = URL(string: "https://lottowizard.net/mobile-app/?shell=1&native=ios")
    #endif

    static var isConfigured: Bool {
        guard let absolute = startURL?.absoluteString else {
            return false
        }
        return !absolute.contains("your-domain.example")
    }
}
