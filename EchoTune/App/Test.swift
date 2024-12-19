import Foundation
import WebKit
import SwiftUI
import FirebaseRemoteConfig
import Network

enum AppState {
    case main, service
}

struct LocalStorage {
    
    static let shared = LocalStorage()
    
    private init() {  }
    
    @AppStorage("APP_LINK") private var appLink = ""
    @AppStorage("FIRST_LAUNCH") private var firstLaunch = true
    
    func getAppLinkWithStorage() -> String {
        appLink
    }
    
    func setAppLinkWhithStorage(_ link: String) {
        appLink = link
    }
    
    func isFirstLaunch() -> Bool {
        firstLaunch
    }
    
    func setFirstLaunch(_ value: Bool) {
        firstLaunch = value
    }
}



class WebViewHelperViewModel: ObservableObject {
    @Published var state: AppState = .service
    @Published var showAlert: Bool = false
    @Published var finalLink: String?
    @Published var hasParam = false
    
    func fetchFromRemote() async -> URL? {
        let rc = RemoteConfig.remoteConfig()
        
        do {
            let status = try await rc.fetchAndActivate()
            if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                let urlString = rc["privacyLink"].stringValue ?? ""
                guard let url = URL(string: urlString) else { return nil }
                return url
            }
        } catch {
            state = .main
        }
        return nil
    }
}

@available(iOS 17.0, *)
struct BrowserView: View {
    @StateObject var viewModel = WebViewHelperViewModel()
    @StateObject private var themeManager = ThemeManager.shared
    var body: some View {
        Group {
            switch viewModel.state {
            case .main:
                MainFlow().environmentObject(themeManager)
            case .service:
                VStack {
                    if let url = viewModel.finalLink {
                        WebView(url: url, viewModel: viewModel)
                    }
                    if viewModel.hasParam {
                        Button(action: {
                            viewModel.state = .main
                        }, label: {
                            Text("Agree")
                                .customFont(.addButtonText)
                                .foregroundStyle(.black)
                                .padding(EdgeInsets(top: 7, leading: 42, bottom: 7, trailing: 42))
                                .background(Color.mainAdd)
                                .cornerRadius(20)
                        })
                    }
                }
            }
        }
        .alert("No internet", isPresented: $viewModel.showAlert, actions: {
            Button(role: .cancel, action: {}, label: {
                Text("Ok")
            })
        })
        .onAppear(perform: setupView)
    }
    
    private func setupView() {
        let storage = LocalStorage.shared
        if !storage.getAppLinkWithStorage().isEmpty {
            viewModel.finalLink = storage.getAppLinkWithStorage()
            viewModel.state = .service
        } else if storage.isFirstLaunch() {
            Task {
                if let url = await viewModel.fetchFromRemote() {
                    viewModel.finalLink = url.absoluteString
                    viewModel.state = .service
                }
            }
            storage.setFirstLaunch(false)
        } else {
            viewModel.state = .main
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: String
    let viewModel: WebViewHelperViewModel
    private let userAgent = "Mozilla/5.0 (\(UIDevice.current.model); CPU \(UIDevice.current.model) OS \(UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(UIDevice.current.systemVersion) Mobile/15E148 Safari/604.1"
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else { return WKWebView() }
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.customUserAgent = userAgent
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }
            
            if handleCustomSchemes(url: url) {
                decisionHandler(.cancel)
                return
            }
            
            if url.query?.contains("showAgreebutton") == true {
                parent.viewModel.hasParam = true
            } else {
                let storage = LocalStorage.shared
                storage.setAppLinkWhithStorage(parent.viewModel.hasParam ? "" : url.absoluteString)
            }
            
            decisionHandler(.allow)
        }
        
        private func handleCustomSchemes(url: URL) -> Bool {
            let schemes = ["tel", "mailto", "tg", "phonepe", "paytmmp"]
            guard schemes.contains(url.scheme ?? "") else { return false }
            UIApplication.shared.open(url, options: [:])
            return true
        }
    }
}

