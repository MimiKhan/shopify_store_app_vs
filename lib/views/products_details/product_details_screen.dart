import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/shopify_models/models/models.dart';
import 'package:shopify_store_app/views/cart/add_to_cart/new_add_to_cart_screen.dart';
import 'package:shopify_store_app/views/main_ui/main_screen.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shopify_store_app/views/products_details/custom_image_view.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  late Product product;
  List<String> variantsTitle = [];
  List<String> collectionsTitle = [];
  String onlineStoreUrl = '';

  bool _descriptionIconSelected = true;
  bool _optionIconSelected = true;
  bool _tagsIconSelected = true;
  bool _categoryIconSelected = true;
  String selectedItem = '';

  final wishlistController = Get.find<WishListController>();
  final cartController = Get.find<CartController>();

  late bool _favIconState;

  String markdown = '';

  // final panelController = PanelController();
  // final controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    product = widget.product;
    debugPrint('Product Description **: ${product.description} '
        '**${product.description!.length.toString()}**:**');

    getProductVariantsTitle(product);
    getProductCollectionsTitle(product);
    String? html = product.descriptionHtml;
    markdown = html2md.convert(html!);
    // onlineStoreUrl = product.onlineStoreUrl!;
    _favIconState = wishlistController.favouritesList.contains(product);
    debugPrint("Fav Icon State : $_favIconState");

    super.initState();
  }

  void getProductVariantsTitle(Product product) {
    for (var element in product.productVariants) {
      variantsTitle.add(element.title);
    }
  }

  void getProductCollectionsTitle(Product product) {
    if (product.collectionList!.isNotEmpty) {
      for (var element in product.collectionList!.reversed) {
        collectionsTitle.add(element.title);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _favIconState = wishlistController.favouritesList.contains(product);
    // final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => NewAddToCartScreen(product: product));
        },
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        label: const Text(
          'Add to Bag',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          CupertinoIcons.bag_badge_plus,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            expandedHeight: 325,
            floating: true,
            pinned: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            // leading: GestureDetector(
            //   onTap: () {
            //     Navigator.pop(context);
            //     // Get.back();
            //   },
            //   child: const Icon(
            //     Icons.close,
            //     color: Colors.black,
            //   ),
            // ),
            actions: [
              IconButton(
                key: UniqueKey(),
                onPressed: () {
                  setState(() {
                    wishlistController.toggleFavorites(product);
                  });
                  debugPrint("Length of Fav List : ${wishlistController.favouritesList.length}");
                },
                icon: Icon(
                  _favIconState
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: _favIconState ? Colors.red : null,
                ),
              ),
              PopupMenuButton(
                onSelected: (value) {
                  // your logic
                  setState(() {
                    selectedItem = value.toString();
                  });
                  debugPrint(value);
                  // Navigator.pushNamed(context, value.toString());
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: const Text('My Cart'),
                      onTap: () {
                        Get.to(() => MainScreen(
                              selectedIndex: 3,
                            ));
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Save to Wishlist'),
                      onTap: () {
                        wishlistController.toggleFavorites(product);
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Share'),
                      onTap: () {},
                    ),
                  ];
                },
              ),
            ],
            flexibleSpace: SizedBox(
              width: size.width,
              child: ListView.builder(
                itemCount: product.images.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const PageScrollPhysics(),
                itemBuilder: (BuildContext context, int imageListIndex) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap:(){
                          Get.to(() => CustomImageViewer(product: product));
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child:
                              CachedNetworkImage(
                            imageUrl: product.images[imageListIndex].originalSrc,
                            placeholder: (context, url) => Image.asset(
                                'assets/images/lime-light-logo.png',
                                fit: BoxFit.cover),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                            height: 375,
                            width: size.width,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          "${imageListIndex + 1}/${product.images.length}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1.2,
                  color: Colors.grey,
                  indent: 40,
                  endIndent: 40,
                ),
                // Title Widget
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        product.title,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // Price Widget
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.productVariants[0].price.formattedPrice,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                // Description Widget
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _descriptionIconSelected = !_descriptionIconSelected;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: size.width - 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(_descriptionIconSelected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: !_descriptionIconSelected,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 2,
                          child: SizedBox(
                            width: size.width - 30,
                            child: MarkdownBody(
                              shrinkWrap: true,
                              data: markdown,
                              softLineBreak: true,
                              fitContent: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Additional Information Widget
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _optionIconSelected = !_optionIconSelected;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: size.width - 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Additional Information',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(_optionIconSelected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: !_optionIconSelected,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: SizedBox(
                          width: size.width - 10,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: product.option.length,
                            scrollDirection: Axis.vertical,
                            // itemExtent: 50,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, int optionsListViewIndex) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Text(
                                      product.option[optionsListViewIndex].name,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:200,
                                    child: Flexible(
                                      fit:FlexFit.loose,
                                      flex:2,
                                      child: Text(
                                        product
                                            .option[optionsListViewIndex].values
                                            .join(' , '),
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Categories Widget
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _categoryIconSelected = !_categoryIconSelected;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: size.width - 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(_categoryIconSelected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: !_categoryIconSelected,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 2),
                    child: SizedBox(
                      width: size.width - 30,
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: product.collectionList?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, int collectionListViewIndex) {
                          return TextButton(
                            onPressed: () {},
                            child: Text(
                              product.collectionList![collectionListViewIndex]
                                  .title
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Product Tags Widget
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _tagsIconSelected = !_tagsIconSelected;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: size.width - 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Product Tags',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(_tagsIconSelected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: !_tagsIconSelected,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 2),
                    child: SizedBox(
                      width: size.width - 30,
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: product.tags.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, int tagsListViewIndex) {
                          return TextButton(
                            onPressed: () {},
                            child: Text(
                              product.tags[tagsListViewIndex].toString(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Random space at bottom
                const SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Text(product.productVariants[0].price.formattedPrice),
          // ),
        ],
      ),
      /*SlidingUpPanel(
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              expandedHeight: 325,
              floating: true,
              pinned: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    wishlistController.toggleFavorites(product);
                    },
                  icon: Icon(
                    _favIconState
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: _favIconState ? Colors.red : Colors.grey,
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    // your logic
                    setState(() {
                      selectedItem = value.toString();
                    });
                    debugPrint(value);
                    // Navigator.pushNamed(context, value.toString());
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: const Text('My Cart'),
                        onTap: () {
                          Get.to(() => MainScreen(
                                selectedIndex: 3,
                              ));
                        },
                      ),
                      PopupMenuItem(
                        child: const Text('Save to Wishlist'),
                        onTap: () {
                          wishlistController.toggleFavorites(product);
                        },
                      ),
                      PopupMenuItem(
                        child: const Text('Share'),
                        onTap: () {},
                      ),
                    ];
                  },
                ),
              ],
              flexibleSpace: Container(
                child: ListView.builder(
                  itemCount: product.images.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (BuildContext context, int imageListIndex) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child:
                              // Image(
                              //   fit: BoxFit.fill,
                              //   filterQuality: FilterQuality.high,
                              //   width: size.width,
                              //   height: 375,
                              //   image: NetworkImage(
                              //       product.images[imageListIndex].originalSrc),
                              // ),
                              CachedNetworkImage(
                            imageUrl:
                                product.images[imageListIndex].originalSrc,
                            placeholder: (context, url) => Image.asset(
                                'assets/images/lime-light-logo.png',
                                fit: BoxFit.cover),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                            height: 375,
                            width: size.width,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text(
                            "${imageListIndex + 1}/${product.images.length}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1.2,
                    color: Colors.grey,
                    indent: 40,
                    endIndent: 40,
                  ),
                  // Title Widget
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Price Widget
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.productVariants[0].price.formattedPrice,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // Description Widget
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _descriptionIconSelected = !_descriptionIconSelected;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: size.width - 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(_descriptionIconSelected
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !_descriptionIconSelected,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            flex: 2,
                            child: SizedBox(
                              width: size.width - 30,
                              child: MarkdownBody(
                                shrinkWrap: true,
                                data: markdown,
                                softLineBreak: true,
                                fitContent: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Additional Information Widget
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _optionIconSelected = !_optionIconSelected;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: size.width - 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Additional Information',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(_optionIconSelected
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !_optionIconSelected,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: SizedBox(
                            width: size.width - 10,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: product.option.length,
                              scrollDirection: Axis.vertical,
                              itemExtent: 40,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, int optionsListViewIndex) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Text(
                                        product.option[optionsListViewIndex].name,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        product.option[optionsListViewIndex].values
                                            .join(','),
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Categories Widget
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _categoryIconSelected = !_categoryIconSelected;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: size.width - 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(_categoryIconSelected
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !_categoryIconSelected,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 2),
                      child: SizedBox(
                        width: size.width - 30,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: product.collectionList?.length ?? 0,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, int collectionListViewIndex) {
                            return TextButton(
                              onPressed: () {},
                              child: Text(
                                product.collectionList![collectionListViewIndex]
                                    .title
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Product Tags Widget
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _tagsIconSelected = !_tagsIconSelected;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: size.width - 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Product Tags',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(_tagsIconSelected
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !_tagsIconSelected,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 2),
                      child: SizedBox(
                        width: size.width - 30,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: product.tags.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, int tagsListViewIndex) {
                            return TextButton(
                              onPressed: () {},
                              child: Text(
                                product.tags[tagsListViewIndex].toString(),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Random space at bottom
                  const SizedBox(
                    height: 300,
                  ),
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Text(product.productVariants[0].price.formattedPrice),
            // ),
          ],
        ),
        controller: panelController,
        maxHeight: panelHeightOpen,
        defaultPanelState: PanelState.CLOSED,
        minHeight: 0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        backdropTapClosesPanel: true,
        panelBuilder: (controller) {
          return AddToCartScreen(
              product: product,
              controller: controller,
              panelController: panelController);
        },
      ),*/
    );
  }
}
