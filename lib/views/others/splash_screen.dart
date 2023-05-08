import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopify_store_app/controllers/home_controller.dart';
import 'package:shopify_store_app/views/main_ui/main_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // bool _shimmerEnabled = true;

  late AnimationController _controller;

  bool is_loaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final homeController = Get.find<HomeController>();
      await homeController.initData().then((value) {
        _controller.forward();
        Future.delayed(const Duration(seconds: 6),
            () {
              return Get.to(() => MainScreen(selectedIndex: 0));
            }
        );
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      body: Center(
        child: LottieBuilder.asset(
          'assets/json/small-shopify-animation.json',
          controller: _controller,
          // width: 300,
          // height: 280,
          fit: BoxFit.cover,
          animate: true,
          repeat: true,

        ),
      ),
    );
  }
}
/*
SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 320,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 60,
                    left: 35,
                    child: Shimmer.fromColors(
                      enabled: _shimmerEnabled,baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(width: 150,height: 20,color: Colors.white,),),
                  ),
                  Positioned(
                    bottom: 7,
                    left: size.width / 10.5,
                    right: size.width / 10.5,
                    child: Shimmer.fromColors(
                      enabled: _shimmerEnabled,
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,

                      child: Container(
                        width: size.width * 0.9,
                        height: 180,
                        color: Colors.white,

                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        enabled: _shimmerEnabled,
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(width: 120,height: 15,color: Colors.white,),),
                      Shimmer.fromColors(
                        enabled: _shimmerEnabled,baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(width: 80,height: 15,color: Colors.white,),),
                    ],
                  ),
                ),
                ListView(
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
                            mainAxisExtent: 350,
                          ),
                          itemCount: 4,
                          itemBuilder:
                              (BuildContext context, int gridViewIndex) {
                            // var quantityAvailable = controller
                            //     .bestSellingProducts[gridViewIndex]
                            //     .productVariants[0]
                            //     .quantityAvailable!;
                            return Container(
                              width: 150,
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                // border: Border.all(width: 0.7, color: Colors.grey),
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    const BorderRadius.only(
                                        topLeft:
                                        Radius.circular(15),
                                        topRight:
                                        Radius.circular(15)),
                                    child: Shimmer.fromColors(
                                      enabled: _shimmerEnabled,
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 175,
                                        height: 200,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5),
                                    child: Shimmer.fromColors(
                                      enabled: _shimmerEnabled,
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 180,
                                        height: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Shimmer.fromColors(
                                    enabled: _shimmerEnabled,
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: 120,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                    ]),
              ],
            ),
          ],
        ),
      ),
 */
