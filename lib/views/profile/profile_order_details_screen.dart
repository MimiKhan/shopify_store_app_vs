import 'package:flutter/material.dart';
import 'package:shopify_store_app/shopify_models/models/models.dart';

class ProfileOrderDetailsScreen extends StatelessWidget {
  final Order order;

  const ProfileOrderDetailsScreen({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
