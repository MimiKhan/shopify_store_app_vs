import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/widgets/exit_popup.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.checkoutUrl}) : super(key: key);
  final String checkoutUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final checkoutController = Get.find<CheckoutController>();

  InAppWebViewController? _webViewController;
  PullToRefreshController? _pullToRefreshController;
  late String url;
  double _progress = 0;
  bool _isLoading = true;
  bool _isCheckoutComplete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.checkoutUrl;
    _pullToRefreshController = PullToRefreshController(
        onRefresh: () {
          _webViewController!.reload();
        },
        options: PullToRefreshOptions(color: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showBackPopuponCheckout(context),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      InAppWebView(
                        onTitleChanged: (controller, title) {
                          var newTitle = title!.split("/").last;
                          debugPrint("Title>> $newTitle");
                        },
                        pullToRefreshController: _pullToRefreshController,
                        onWebViewCreated: (controller) =>
                            _webViewController = controller,
                        initialUrlRequest: URLRequest(
                          url: Uri.parse(url),
                        ),
                        onLoadStop: (controller, url) {
                          _pullToRefreshController!.endRefreshing();
                          if (mounted) {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                          if (url.toString().contains('/checkouts/') &&
                              url.toString().contains('/thank_you')) {
                            setState(() {
                              _isCheckoutComplete = true;
                            });
                            checkoutController.dispose();
                            // Navigator.pushReplacementNamed(context, '/confirmation');
                            Get.to('/mainScreen');
                          }
                        },
                        onProgressChanged: (controller, progress) {
                          if (progress == 100) {
                            _pullToRefreshController!.endRefreshing();
                          }
                          if (mounted) {
                            setState(() {
                              _progress = progress / 100;
                            });
                          }
                        },
                      ),
                      Visibility(
                        visible: _isLoading,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.fromSwatch().copyWith(
                            secondary: Colors.yellow,
                            primary: Colors.blue,
                          )),
                          child:
                          // CircularProgressIndicator(
                          //   value: _progress,
                          //   backgroundColor: Colors.blueGrey,
                          // ),
                          const CupertinoActivityIndicator(radius: 20,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
