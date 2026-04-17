import SwiftUI
import UIKit
import WebKit

final class MobileWebViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var statusText = "Opening Lotto Wizard..."
    @Published var errorText: String?

    let startURL = LottoWizardConfig.startURL

    var isConfigured: Bool {
        LottoWizardConfig.isConfigured
    }
}

struct MobileWebView: UIViewRepresentable {
    let url: URL
    @ObservedObject var model: MobileWebViewModel
    let reloadToken: UUID

    func makeCoordinator() -> Coordinator {
        Coordinator(model: model, allowedHost: url.host)
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.05, green: 0.09, blue: 0.13, alpha: 1.0)
        webView.scrollView.backgroundColor = webView.backgroundColor
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if context.coordinator.lastReloadToken != reloadToken {
            context.coordinator.lastReloadToken = reloadToken
            webView.load(URLRequest(url: url))
        }
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        let model: MobileWebViewModel
        let allowedHost: String?
        var lastReloadToken = UUID()

        init(model: MobileWebViewModel, allowedHost: String?) {
            self.model = model
            self.allowedHost = allowedHost
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            model.isLoading = true
            model.errorText = nil
            model.statusText = "Opening Lotto Wizard..."
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            model.isLoading = false
            model.statusText = "Lotto Wizard is ready."
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            model.isLoading = false
            model.errorText = "Lotto Wizard could not connect. Make sure the mobile page or hosted site is available."
            model.statusText = "Connection failed."
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            model.isLoading = false
            model.errorText = "Lotto Wizard could not connect. Make sure the mobile page or hosted site is available."
            model.statusText = "Connection failed."
        }

        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }

            if let scheme = url.scheme?.lowercased(), !["http", "https"].contains(scheme) {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }

            if let host = url.host, let allowedHost, host.caseInsensitiveCompare(allowedHost) != .orderedSame {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }

            decisionHandler(.allow)
        }
    }
}
