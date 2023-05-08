import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomImageViewer extends StatefulWidget {
  final Product product;

  const CustomImageViewer({Key? key, required this.product}) : super(key: key);

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
           onPressed: (){
             Get.back();
           }, icon: const Icon(Icons.arrow_back,color: Colors.white,),
        ),
        backgroundColor: Colors.black,
        title: Text(
          widget.product.title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          maxLines: 1,
            overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),

              itemCount: widget.product.images.length,
              itemBuilder: (context, index) {
                return PhotoView(
                  imageProvider:
                      NetworkImage(widget.product.images[index].originalSrc),
                  minScale: PhotoViewComputedScale.covered,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: widget.product.images.length,
            axisDirection: Axis.horizontal,
            onDotClicked: (index){
              _pageController.jumpToPage(index);
            },
            effect: const WormEffect(
              dotWidth: 15.0,
              dotHeight: 15.0,
              activeDotColor: Colors.white,
              spacing: 20,
            ),
          ),
        ],
      ),
    );
  }
}
