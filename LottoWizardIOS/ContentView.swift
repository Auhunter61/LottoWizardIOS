import SwiftUI

struct ContentView: View {
    @StateObject private var model = MobileWebViewModel()
    @State private var reloadToken = UUID()

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.09, blue: 0.13)
                .ignoresSafeArea()

            if model.isConfigured, let startURL = model.startURL {
                VStack(spacing: 0) {
                    statusBar

                    MobileWebView(url: startURL, model: model, reloadToken: reloadToken)
                        .overlay(alignment: .top) {
                            if model.isLoading {
                                ProgressView()
                                    .tint(Color(red: 0.84, green: 0.66, blue: 0.30))
                                    .padding(.top, 12)
                            }
                        }
                }
            } else {
                setupView
            }
        }
    }

    private var statusBar: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lotto Wizard")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text(model.statusText)
                        .font(.footnote)
                        .foregroundStyle(Color(red: 0.72, green: 0.79, blue: 0.86))
                }

                Spacer()

                Button("Reload") {
                    reloadToken = UUID()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.84, green: 0.66, blue: 0.30))
            }

            if let errorText = model.errorText {
                Text(errorText)
                    .font(.footnote)
                    .foregroundStyle(Color(red: 0.96, green: 0.79, blue: 0.60))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(red: 0.09, green: 0.13, blue: 0.20))
    }

    private var setupView: some View {
        VStack(spacing: 18) {
            Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                .font(.system(size: 52))
                .foregroundStyle(Color(red: 0.27, green: 0.65, blue: 0.93))

            Text("Lotto Wizard for iPhone is ready")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(.white)

            Text("Set the Lotto Wizard mobile page in LottoWizardConfig.swift. In the iOS Simulator you can use the local page on your Mac. For a real iPhone, point it to the hosted mobile site.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.72, green: 0.79, blue: 0.86))
                .frame(maxWidth: 360)
        }
        .padding(30)
    }
}

#Preview {
    ContentView()
}
