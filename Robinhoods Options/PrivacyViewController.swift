import UIKit
import WebKit

class PrivacyController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    let urlToLoad = "https://doc-hosting.flycricket.io/avix-party-game-privacy-policy/29451367-8a3b-46ad-8756-e1ad162eab05/privacy" 
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: urlToLoad) else {
            print("Неверный URL")
            return
        }

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Ошибка загрузки: \(error)")
    }
}
