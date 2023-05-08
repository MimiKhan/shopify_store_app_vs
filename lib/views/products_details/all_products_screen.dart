import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/products_list_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/new_ui_designs/product_details/ui/product_details_ui_screen.dart';
import 'package:shopify_store_app/services/hex_color.dart';
import 'package:shopify_store_app/shopify_models/enums/enums.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/products_details/new_product_details_screen.dart';
import 'package:shimmer/shimmer.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts>
    with TickerProviderStateMixin {
  // this variable determines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;
  bool _shimmerEnable = true;
  List<bool> isLayoutCardEnabled = [];
  List<bool> isPriceRangeCardEnabled = [];
  bool isLoading = false;

  // scroll controller
  late ScrollController _scrollController;

  final productListController = Get.find<ProductsListController>();
  final cartController = Get.find<CartController>();
  final wishListController = Get.find<WishListController>();
  var _selectedLayoutIndex = 0;

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
    // productListController.isDataLoading.value
    //     ? setState(() {
    //         _shimmerEnable = true;
    //       })
    //     : setState(() {
    //         _shimmerEnable = false;
    //       });
    // debugPrint("Products Count **: ${productListController.productsCount}");

    await Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          _shimmerEnable = false;
          debugPrint(
              "Products Count **: ${productListController.productsCount}");
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
    Get.to(() => ProductDetailsUI(product: product));
  }

  var iconList = <IconData>[
    Icons.grid_view_rounded,
    CupertinoIcons.rectangle_grid_3x2,
    CupertinoIcons.square_fill,
    CupertinoIcons.list_bullet
  ];

  var priceRangeList = <String>[
    "<\$100",
    "\$100 - \$500",
    "\$500 - \$1000",
    ">\$1000",
  ];

  int _selectedSortIndex = -1;
  var sortTypeList = <String>[
    "Price: High to Low",
    "Price: Low to high",
    "Alphabetically A to Z",
    "Alphabetically Z to A",
    "By Date: Newest to Oldest",
    "By Date: Oldest to Newest",
    "By BestSelling",
  ];

  final _chipsData = <String>['On Sale', '\$0 - \$499', '\$500 < '];
  int _selectedChipIndex = -1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
      bottomSheet: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: FilledButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      useSafeArea: true,
                      context: context,
                      isDismissible: true,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Sort',
                                style:
                                    AppStyle.gfPoppinsMediumBlack(fontSize: 26),
                              ),
                              // const Divider(),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: sortTypeList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  bool isSelected = _selectedSortIndex == index;
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _selectedSortIndex = index;
                                      });

                                      debugPrint("Sort Index :: $index ::");
                                      if (index == 0) {
                                        await productListController
                                            .fetchSortedProducts(
                                                sortKeyProduct:
                                                    SortKeyProduct.PRICE,
                                                reverse: true)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      } else if (index == 1) {
                                        await productListController
                                            .fetchSortedProducts(
                                                sortKeyProduct:
                                                    SortKeyProduct.PRICE,
                                                reverse: false)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      } else if (index == 2) {
                                        await productListController
                                            .fetchSortedProducts(
                                                sortKeyProduct:
                                                    SortKeyProduct.TITLE,
                                                reverse: false)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      } else if (index == 3) {
                                        await productListController
                                            .fetchSortedProducts(
                                                sortKeyProduct:
                                                    SortKeyProduct.TITLE,
                                                reverse: true)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      } else if (index == 4) {
                                        await productListController
                                            .fetchSortedProducts(
                                                sortKeyProduct:
                                                    SortKeyProduct.CREATED_AT,
                                                reverse: false)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      } else if (index == 5) {
                                        await productListController
                                            .fetchSortedProducts(
                                                sortKeyProduct:
                                                    SortKeyProduct.CREATED_AT,
                                                reverse: true)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        await productListController
                                            .fetchSortedProducts(
                                                sortKeyProduct:
                                                    SortKeyProduct.BEST_SELLING,
                                                reverse: false)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.blueAccent
                                            : Colors.white,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(sortTypeList[index]),
                                        trailing: isSelected
                                            ? const Icon(Icons.check)
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.black),
                icon: const Icon(
                  CupertinoIcons.arrow_up_arrow_down,
                  size: 18,
                ),
                label: Text(
                  "Sort",
                  style: AppStyle.gfPoppinsRegularWhite(fontSize: 20),
                ),
              ),
            ),
            /*const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: FilledButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      useSafeArea: true,
                      context: context,
                      isDismissible: true,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                'Filters',
                                style:
                                    AppStyle.gfPoppinsMediumBlack(fontSize: 24),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Text(
                                'By Price Range',
                                style: AppStyle.gfPoppinsMediumBlack(
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                height: 55,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 5,
                                      mainAxisExtent: 120
                                    ),
                                    itemCount: priceRangeList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      isPriceRangeCardEnabled.add(false);
                                      // if (index == 0 && isPriceRangeCardEnabled.isEmpty) {
                                      //   // Set the first item as selected if no items are currently selected
                                      //   isPriceRangeCardEnabled.add(true);
                                      // } else {
                                      //   isPriceRangeCardEnabled.add(false);
                                      // }
                                      return GestureDetector(
                                        onTap: () {
                                          isPriceRangeCardEnabled.replaceRange(
                                              0, isPriceRangeCardEnabled.length, [
                                            for (int i = 0; i < isPriceRangeCardEnabled.length; i++)
                                              false
                                          ]);
                                          isPriceRangeCardEnabled[index] = true;
                                          setState(() {
                                            _selectedPriceIndex = index;
                                            debugPrint(
                                                "Selected Price : $_selectedPriceIndex : ");

                                          });
                                          // isPriceRangeCardEnabled =
                                          // List<bool>.generate(priceRangeList.length, (i) => i == index);
                                          // setState(() {
                                          //   _selectedPriceIndex = index;
                                          // });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(12),
                                            color: isPriceRangeCardEnabled[index]
                                                ? Colors.black
                                                : const Color(0xfffafafa),
                                          ),
                                          child: Text(
                                            priceRangeList[index],
                                            style: isPriceRangeCardEnabled[index]
                                            ? AppStyle.gfPoppinsRegularWhite(fontSize: 16)
                                                : AppStyle.gfPoppinsRegularBlack(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )



                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.filter_alt,
                  size: 18,
                ),
                label: Text(
                  "Filter",
                  style: AppStyle.gfPoppinsRegularWhite(fontSize: 20),
                ),
              ),
            ),*/
          ],
        ),
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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 40,
                  child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: iconList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // isCardEnabled.add(false);
                        if (index == 0 && isLayoutCardEnabled.isEmpty) {
                          // Set the first item as selected if no items are currently selected
                          isLayoutCardEnabled.add(true);
                        } else {
                          isLayoutCardEnabled.add(false);
                        }
                        return GestureDetector(
                          onTap: () {
                            isLayoutCardEnabled.replaceRange(
                                0, isLayoutCardEnabled.length, [
                              for (int i = 0;
                                  i < isLayoutCardEnabled.length;
                                  i++)
                                false
                            ]);
                            isLayoutCardEnabled[index] = true;
                            setState(() {
                              _selectedLayoutIndex = index;
                              debugPrint(
                                  "Selected Type : $_selectedLayoutIndex : ");
                              // Navigator.pop(context);
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(12),
                              color: isLayoutCardEnabled[index]
                                  ? Colors.black
                                  : const Color(0xfffafafa),
                            ),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                iconList[index],
                                size: 25,
                                color: isLayoutCardEnabled[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text('Filters',style: AppStyle.gfPoppinsMediumBlack(fontSize: 18),),
              leading: const Icon(Icons.filter_list),
              subtitle: _selectedChipIndex >= 0
                  ? Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          _selectedChipIndex = -1;
                        });
                      }
                      productListController.refresh();
                    },
                    child: Text(
                      'Clear Filter',
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.underline),
                    )),
              )
                  : const SizedBox(
                height: 0,
                width: 0,
              ),
              // trailing: TextButton(
              //     onPressed: () {
              //       if (mounted) {
              //         setState(() {
              //           _selectedChipIndex = -1;
              //         });
              //       }
              //       productListController.refresh();
              //     },
              //     child: Text(
              //       'Clear Filter',
              //       style: GoogleFonts.poppins(
              //           decoration: TextDecoration.underline),
              //     )),
              initiallyExpanded: false,
              children: [
                Wrap(
                  spacing: 8.0, // spacing between chips
                  children: List<Widget>.generate(
                    _chipsData.length,
                    (int index) {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            _selectedChipIndex = index;
                          });

                          if (index == 0) {
                            await productListController.fetchProductsOnSale();
                          } else if (index == 1) {
                            await productListController.fetchProductsPriceRange(
                                startingPoint: 0, endingPoint: 499);
                          } else if (index == 2) {
                            await productListController.fetchProductsPriceRange(
                                startingPoint: 499, endingPoint: 1500);
                          }
                        },
                        child: Chip(
                          label: Text(_chipsData[index]),
                          backgroundColor: _selectedChipIndex == index
                              ? Colors.blue
                              : Colors.grey[300],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            /*Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Wrap(
                      spacing: 8.0, // spacing between chips
                      children: List<Widget>.generate(
                        _chipsData.length,
                        (int index) {
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                _selectedChipIndex = index;
                              });

                              if (index == 0) {
                                await productListController
                                    .fetchProductsOnSale();
                              } else if (index == 1) {
                              } else if (index == 2) {}
                            },
                            child: Chip(
                              label: Text(_chipsData[index]),
                              backgroundColor: _selectedChipIndex == index
                                  ? Colors.blue
                                  : Colors.grey[300],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              _selectedChipIndex = -1;
                            });
                          }
                          productListController.refresh();
                        },
                        child: Text(
                          'Clear Filter',
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.underline),
                        )),
                  )
                ],
              ),
            ),*/
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.0),
            //   child: Divider(),
            // ),
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
                                if (_selectedLayoutIndex == 0)
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
                                    },
                                  )
                                else if (_selectedLayoutIndex == 1)
                                  GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
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
                                                              Radius.circular(
                                                                  15),
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
                                                              fit:
                                                                  BoxFit.cover),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
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
                                                              .productVariants[
                                                                  0]
                                                              .price
                                                              .formattedPrice,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                else if (_selectedLayoutIndex == 2)
                                  ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 20),
                                        child: Container(
                                          width: size.width,
                                          height: 540,
                                          decoration: BoxDecoration(
                                            color: HexColor("#ffffff"),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  width: size.width,
                                                  height: 580,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child:
                                                      // Placeholder(),
                                                      CachedNetworkImage(
                                                    height: 580,
                                                    width: size.width,
                                                    imageUrl: controller
                                                        .productsList[index]
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
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .productsList[index]
                                                          .title,
                                                      style: AppStyle
                                                          .gfPoppinsMediumBlack(
                                                              fontSize: 16),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      controller
                                                          .productsList[index]
                                                          .productVariants
                                                          .first
                                                          .price
                                                          .formattedPrice,
                                                      style: AppStyle
                                                          .gfPoppinsMediumBlack(
                                                              fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: controller.productsCount,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                  )
                                else
                                  ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: size.width,
                                          height: 250,
                                          decoration: BoxDecoration(
                                            color: HexColor("#ffffff"),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: 120,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: CachedNetworkImage(
                                                    height: 200,
                                                    width: 150,
                                                    imageUrl: controller
                                                        .productsList[index]
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
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .productsList[index]
                                                            .title,
                                                        style: AppStyle
                                                            .gfPoppinsMediumBlack(
                                                                fontSize: 16),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        controller
                                                            .productsList[index]
                                                            .productVariants
                                                            .first
                                                            .price
                                                            .formattedPrice,
                                                        style: AppStyle
                                                            .gfPoppinsMediumBlack(
                                                                fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: controller.productsCount,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                  ),
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
