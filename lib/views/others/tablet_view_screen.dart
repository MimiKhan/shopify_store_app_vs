
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shopify_store_app/services/configs.dart';
import 'package:shopify_store_app/widgets/exit_popup.dart';

class TabletViewScreen extends StatefulWidget {
  const TabletViewScreen({Key? key}) : super(key: key);

  @override
  State<TabletViewScreen> createState() => _TabletViewScreenState();
}

class _TabletViewScreenState extends State<TabletViewScreen> {
  InAppWebViewController? _webViewController;
  PullToRefreshController? _pullToRefreshController;
  late String url;
  // double _progress = 0;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = "https://${CustomConfig.shopifyStoreLink}";
    _pullToRefreshController = PullToRefreshController(
        onRefresh: () {
          _webViewController!.reload();
        },
        options: PullToRefreshOptions(color: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    // No tablet View Available
    /*return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Coming Soon',
              style: AppStyle.gfPoppinsBoldBlack(fontSize: 24),
            ),
            10.ph,
            Text(
              'Tablet View is coming soon',
              style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
            ),
            10.ph,
            Row(
              children: [
                Text(
                  'Please refer to webview instead.',
                  style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                ),
                15.pw,
                IconButton(
                  icon: const Icon(
                    Icons.open_in_browser_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            65.ph,
            FilledButton.icon(
                onPressed: () {
                  exit(0);
                },
                icon: const Icon(Icons.exit_to_app),
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(220, 80)),
                label: Text(
                  'Exit',
                  style: AppStyle.gfPoppinsBoldWhite(fontSize: 30),
                )),
          ],
        ),
      ),
    );*/

    // Web View
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
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
                              const CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                              ),
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
