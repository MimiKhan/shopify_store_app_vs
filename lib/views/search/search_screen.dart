import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/product_controller.dart';
import 'package:shopify_store_app/shopify_models/models/models.dart';
import 'package:shopify_store_app/views/categories/collections_details_screen.dart';
import 'package:shopify_store_app/views/products_details/new_product_details_screen.dart';
import 'package:shopify_store_app/views/products_details/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final productController = Get.find<ProductController>();
  final _controller = TextEditingController(text: '');

  void _navigateToProductDetailScreen(Product product) {
    debugPrint(
        "Product Price **: CP :${product.productVariants.first.compareAtPrice?.formattedPrice} :*: P : ${product.productVariants.first.price.formattedPrice}");
    debugPrint("Product ID :** : ${product.id} :: ${product.handle}");
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    Get.to(() => ProductDetailScreen(product: product));
  }

  // void _navigateToCollectionDetailScreen(
  //     String collectionId, String collectionTitle) {
  //   Get.to(() => CollectionDetailScreen(
  //       collectionId: collectionId, collectionTitle: collectionTitle));
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: GetX<ProductController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Search Products ",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /*ToggleSwitch(
                          minWidth: 110.0,
                          animationDuration: 1,
                          initialLabelIndex: 0,
                          cornerRadius: 20.0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          totalSwitches: 2,
                          labels: const ['Product', 'Collection'],
                          icons: const [
                            FontAwesomeIcons.shirt,
                            FontAwesomeIcons.barsProgress
                          ],
                          changeOnTap: true,
                          activeBgColors: const [
                            [Colors.blue],
                            [Colors.pink]
                          ],
                          animate: true,
                          curve: Curves.elasticInOut,
                          onToggle: (index) {
                            debugPrint('switched to: $index');
                            _toggleButtonIndex = index!;
                          },
                        ),*/
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18),
                          controller: _controller,
                          onChanged: (value) {
                            controller.searchForProducts(value);
                          },
                          decoration: InputDecoration(
                              hintText: '...',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(),
                                gapPadding: 8,
                              ),
                              contentPadding: const EdgeInsets.all(8),
                              helperText: 'Search any Product',
                              prefixIcon: const Icon(CupertinoIcons.search)
                              //fillColor: Colors.green
                              ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      /*Center(
                          child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.search,
                                size: 35,
                              ),
                              onPressed: () => _searchForProduct(_controller.text)),
                        ),*/
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Center(
                  child: Column(
                    children: _buildProductList(),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildProductList() {
    List<Widget> widgetList = [];
    for (var product in productController.productsBySearch) {
      widgetList.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _navigateToProductDetailScreen(product);
            });
          },
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: NetworkImage(
                  product.images[0].originalSrc,
                ),
                height: 65,
                width: 75,
              ),
            ),
            title: Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
        ),
      );
    }
    return widgetList;
  }

/*_buildCollectionTile() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _navigateToCollectionDetailScreen(collection.id,collection.title);
        });
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image(
            image: NetworkImage(
              collection.image!.originalSrc,
            ),
            height: 65,
            width: 75,
          ),
        ),
        title: Text(
          collection.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
    );
  }*/
}
