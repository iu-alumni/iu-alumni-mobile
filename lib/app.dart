import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

// The URL of the web app opened by the Telegram bot.
// Override at build time via: --dart-define=MOBILE_URL=https://...
const _mobileUrl = String.fromEnvironment(
  "MOBILE_URL",
  defaultValue: "https://mobile.alumap.escalopa.com",
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IU Alumni",
      home: WebViewScreen(),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Allow all navigation within the web app
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_mobileUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
