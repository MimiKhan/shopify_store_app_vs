import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/core/utils/color_constant.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shimmer/shimmer.dart';

class ProfileInfoScreen extends StatefulWidget {
  ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final loginController = Get.find<LoginController>();

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();

  bool _shimmerEnable = true;

  Future<void> waitForShimmerEffect() async {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   final loginController = Get.find<LoginController>();
    //
    // });
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        if(mounted){
          setState(() {
            _shimmerEnable = false;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialData().whenComplete(() {
      if(mounted){
        setState(() {
          _shimmerEnable = false;
        });
      }
    });
    // waitForShimmerEffect();

  }

  Future<void> initialData() async {

    // loginController.currentUser.listen((p0) {
    //   setState(() {
    //     _firstNameController.text = p0?.firstName! ?? '';
    //     _emailController.text = (p0?.email! == '') as String;
    //     _lastNameController.text = (p0?.lastName! == '') as String;
    //   });
    // });

    ever(loginController.currentUser, (callback) {
      return _firstNameController.text = callback?.firstName ?? '';
    });
    ever(loginController.currentUser, (callback) {
      return _lastNameController.text = callback?.lastName ?? '';
    });
    ever(loginController.currentUser, (callback) {
      return _emailController.text = callback?.email ?? '';
    });

    // _firstNameController.text =
    //     '${loginController.currentUser.value?.firstName}';
    // _lastNameController.text = '${loginController.currentUser.value?.lastName}';
    // _emailController.text = '${loginController.currentUser.value?.email}';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            _shimmerEnable
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5),
                    child: Shimmer.fromColors(
                      enabled: _shimmerEnable,
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: size.width - 51,
                        height: 50,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: size.width - 51,
                      height: 50,
                      child: TextField(
                        enabled: false,
                        controller: _firstNameController,
                        style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                        decoration: InputDecoration(
                          label: Text(
                            'First Name',
                            style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                          ),
                          filled: true,
                          fillColor: ColorConstant.gray100,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  width: 1.2, color: ColorConstant.black900)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  width: 1.2, color: ColorConstant.black900)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ),
            _shimmerEnable
                ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0, vertical: 5),
              child: Shimmer.fromColors(
                enabled: _shimmerEnable,
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: size.width - 51,
                  height: 50,
                  color: Colors.white,
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: size.width - 51,
                height: 50,
                child: TextField(
                  enabled: false,
                  controller: _lastNameController,
                  style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                  decoration: InputDecoration(
                    label: Text(
                      'Last Name',
                      style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                    ),
                    filled: true,
                    fillColor: ColorConstant.gray100,
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1.2, color: ColorConstant.black900)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1.2, color: ColorConstant.black900)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            _shimmerEnable
                ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0, vertical: 5),
              child: Shimmer.fromColors(
                enabled: _shimmerEnable,
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: size.width - 51,
                  height: 50,
                  color: Colors.white,
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: size.width - 51,
                height: 50,
                child: TextField(
                  enabled: false,
                  controller: _emailController,
                  style: AppStyle.gfPoppinsRegularBlack(fontSize: 21),
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                      style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                    ),
                    filled: true,
                    fillColor: ColorConstant.gray100,
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1.2, color: ColorConstant.black900)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1.2, color: ColorConstant.black900)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
