import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/products_list_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/cart/add_to_cart/new_add_to_cart_screen.dart';
import 'package:shopify_store_app/views/products_details/new_product_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NewAllProductsScreen extends StatefulWidget {
  const NewAllProductsScreen({Key? key}) : super(key: key);

  @override
  State<NewAllProductsScreen> createState() => _NewAllProductsScreenState();
}

class _NewAllProductsScreenState extends State<NewAllProductsScreen>
    with TickerProviderStateMixin {
  // this variable determines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;
  bool _shimmerEnable = true;

  // scroll controller
  late ScrollController _scrollController;

  final productListController = Get.find<ProductsListController>();
  final cartController = Get.find<CartController>();
  final wishListController = Get.find<WishListController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitForShimmerEffect();
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
  }

  Future<void> waitForShimmerEffect() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          _shimmerEnable = false;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 2), curve: Curves.linear);
  }

  void _navigateToProductDetailScreen(Product product) {
    debugPrint('Routing to ${product.id}');
    // Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    Get.to(() => NewProductDetailsScreen(product: product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // set the color of the back icon here
        ),
        title: Text(
          'Products',
          style: AppStyle.gfPoppinsBoldWhite(fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton.extended(
              backgroundColor: Colors.black,
              onPressed: _scrollToTop,
              label: Text(
                "Return to top",
                style: AppStyle.gfPoppinsMediumWhite(fontSize: 18),
              ),
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
      body: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SizedBox(
                  height: 50,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const VerticalDivider(
                          thickness: 1.2,
                          width: 20,
                          indent: 8,
                          endIndent: 8,
                          color: Colors.black,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          padding: const EdgeInsets.all(10),
                          child: Row(children: [
                            Text('Filter',style: AppStyle.gfPoppinsRegularBlack(fontSize: 20),),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              color: Colors.blue,
                              size: 18,
                            ),

                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GetX<ProductsListController>(builder: (controller) {
                return
                    // controller.productsCount == 0
                    //   ? const Center(
                    //       child: CupertinoActivityIndicator(
                    //         radius: 14,
                    //         color: Colors.white,
                    //       ),
                    //     )
                    //   :
                    ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    _shimmerEnable
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Text(
                                  //     'Total Products : ${controller.productsCount.toString()}'),
                                  GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        // childAspectRatio: 1,
                                        crossAxisSpacing: 11,
                                        mainAxisSpacing: 10,
                                        mainAxisExtent: 420,
                                      ),
                                      itemCount: controller.productsList.length,
                                      itemBuilder: (BuildContext context,
                                          int gridViewIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            debugPrint(
                                                "GridView Index : $gridViewIndex");
                                            setState(() {
                                              _navigateToProductDetailScreen(
                                                  controller.productsList[
                                                      gridViewIndex]);
                                            });
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 420,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              // border: Border.all(width: 0.7, color: Colors.grey),
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15)),
                                                  child: SizedBox(
                                                    height: 245,
                                                    width: 195,
                                                    child: Shimmer.fromColors(
                                                      enabled: _shimmerEnable,
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(
                                                        width: 195,
                                                        height: 245,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5.0),
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          enabled: _shimmerEnable,
                                                          baseColor: Colors
                                                              .grey.shade300,
                                                          highlightColor: Colors
                                                              .grey.shade100,
                                                          child: Container(
                                                            width: 100,
                                                            height: 40,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Shimmer.fromColors(
                                                      enabled: _shimmerEnable,
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(
                                                        width: 160,
                                                        height: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Text(
                                  //     'Total Products : ${controller.productsCount.toString()}'),
                                  GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        // childAspectRatio: 1,
                                        crossAxisSpacing: 11,
                                        mainAxisSpacing: 10,
                                        mainAxisExtent: 420,
                                      ),
                                      itemCount: controller.productsList.length,
                                      itemBuilder: (BuildContext context,
                                          int gridViewIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            debugPrint(
                                                "GridView Index : $gridViewIndex");
                                            setState(() {
                                              _navigateToProductDetailScreen(
                                                  controller.productsList[
                                                      gridViewIndex]);
                                            });
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 420,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              // border: Border.all(width: 0.7, color: Colors.grey),
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15)),
                                                  child: SizedBox(
                                                    height: 245,
                                                    width: 195,
                                                    child: CachedNetworkImage(
                                                      imageUrl: controller
                                                          .productsList[
                                                              gridViewIndex]
                                                          .images
                                                          .first
                                                          .originalSrc,
                                                      placeholder: (context,
                                                              url) =>
                                                          Image.asset(
                                                              'assets/images/lime-light-logo.png',
                                                              fit: BoxFit.cover),
                                                      errorWidget: (context, url,
                                                              error) =>
                                                          const Icon(Icons.error),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 10),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        controller
                                                            .productsList[
                                                                gridViewIndex]
                                                            .title,
                                                        style: AppStyle
                                                            .gfPoppinsMediumBlack(
                                                                fontSize: 13),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5.0),
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .productsList[
                                                                  gridViewIndex]
                                                              .productVariants[0]
                                                              .price
                                                              .formattedPrice,
                                                          style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
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
                );
              }),
            ],
          ),
        ),
    );
  }

}
