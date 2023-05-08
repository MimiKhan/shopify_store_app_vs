import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/enums/src/sort_key_product_collection.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/shopify_models/shopify/src/shopify_store.dart';
import 'package:shopify_store_app/views/products_details/product_details_screen.dart';

class CollectionDetailScreen extends StatefulWidget {
  const CollectionDetailScreen(
      {Key? key, required this.collectionId, required this.collectionTitle})
      : super(key: key);
  final String collectionId;
  final String collectionTitle;

  @override
  _CollectionDetailScreenState createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen>
    with TickerProviderStateMixin {
  // this variable determines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  List<Product> products = [];
  bool _isLoading = true;

  String collectionTitle = '';

  @override
  void initState() {
    _fetchProductsByCollectionId();
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 50) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    collectionTitle = widget.collectionTitle;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _navigateToProductDetailScreen(Product product) {
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    Get.to(() => ProductDetailScreen(product: product));
  }

  Future<void> _fetchProductsByCollectionId() async {
    try {
      final shopifyStore = ShopifyStore.instance;
      final products =
          await shopifyStore.getXProductsAfterCursorWithinCollection(
        widget.collectionId,
        100,
        startCursor: null,
        sortKey: SortKeyProductCollection.RELEVANCE,
      );
      if (mounted) {
        setState(() {
          this.products = products!;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          collectionTitle,
          style: const TextStyle(fontSize: 28, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton.extended(
              onPressed: _scrollToTop,
              label: const Text("Return to top"),
              icon: const Icon(Icons.arrow_upward),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        collectionTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),*/
                const SizedBox(
                  height: 15,
                ),
                _isLoading
                    ? const Center(
                        child: CupertinoActivityIndicator(
                          radius: 15,
                        ),
                      )
                    : ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: 1,
                                crossAxisSpacing: 11,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 400,
                              ),
                              itemCount: products.length,
                              itemBuilder:
                                  (BuildContext context, int gridViewIndex) {
                                var quantityAvailable = products[gridViewIndex]
                                    .productVariants[0]
                                    .quantityAvailable;
                                return GestureDetector(
                                  onTap: () {
                                    debugPrint(
                                        "GridView Index : $gridViewIndex");
                                    setState(() {
                                      _navigateToProductDetailScreen(
                                          products[gridViewIndex]);
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // border: Border.all(width: 0.7, color: Colors.grey),
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          child: SizedBox(
                                            height: 245,
                                            width: 195,
                                            child: Image(
                                              image: NetworkImage(
                                                  products[gridViewIndex]
                                                      .images[0]
                                                      .originalSrc),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  products[gridViewIndex]
                                                      .productVariants[0]
                                                      .price
                                                      .formattedPrice,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 5),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                products[gridViewIndex].title,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                                softWrap: true,
                                              )),
                                        ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 5.0),
                                        //   child: Align(
                                        //     alignment: Alignment.bottomCenter,
                                        //     child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: [
                                        //         Text(
                                        //           products[gridViewIndex]
                                        //               .productVariants[0]
                                        //               .price
                                        //               .formattedPrice,
                                        //           style: const TextStyle(
                                        //               color: Colors.black,
                                        //               fontSize: 18,
                                        //               fontWeight:
                                        //                   FontWeight.bold),
                                        //         ),
                                        //         /*Text(
                                        //           products[gridViewIndex]
                                        //                       .productVariants[
                                        //                           0]
                                        //                       .quantityAvailable! >
                                        //                   0
                                        //               ? quantityAvailable! < 10
                                        //                   ? 'Only $quantityAvailable available'
                                        //                   : 'In Stock'
                                        //               : 'Out of Stock',
                                        //           style: TextStyle(
                                        //             color: products[gridViewIndex]
                                        //                         .productVariants[
                                        //                             0]
                                        //                         .quantityAvailable! >
                                        //                     0
                                        //                 ? Colors.green
                                        //                 : Colors.red,
                                        //           ),
                                        //         ),*/
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // IconButton(
                                        //   onPressed: () {},
                                        //   icon: const Icon(
                                        //       Icons.add_shopping_cart_outlined),
                                        //   iconSize: 30,
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
