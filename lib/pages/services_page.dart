import 'package:flutter/material.dart';
import 'package:petrol_app/model/services_model.dart';
import 'package:petrol_app/pages/service_product_display_page.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  Future<List<ServicesModel>> loadServices() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return servicesEx;
  }

  @override
  Widget build(BuildContext context) {
    return ServiceProductDisplayPage<ServicesModel>(
      appBarTitle: 'Services',
      imagePath: 'assets/vectors/service-pg.png',
      loadItems: loadServices,
      getTitle: (item) => item.serviceName,
      getPrice: (item) => item.servicePrice,
      convertToCartItem: (item) => item.convertCartItemModel(),
    );
  }
}
