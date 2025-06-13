import 'package:petrol_app/model/cart_item_model.dart';

class ServicesModel {
  final String serviceName;
  final String serviceId;
  final double serviceQuantity;
  final double servicePrice;
  final double servicesTotalPrice;
  ServicesModel({
    required this.serviceName,
    required this.serviceId,
    required this.servicePrice,
    required this.serviceQuantity,
    required this.servicesTotalPrice
  });

  CartItemModel convertCartItemModel() {
    return CartItemModel(
      uniqueIdentifier: 's_$serviceId:$serviceQuantity',
      productId: serviceId,
      productName: serviceName,
      price: servicePrice,
      quantity: serviceQuantity,
      totalAmount: servicePrice * serviceQuantity,
    );
  }
}

final List<ServicesModel> servicesEx = [
  ServicesModel(
    serviceName: 'Car Wash',
    serviceId: '1',
    servicePrice: 500,
    serviceQuantity: 1,
    servicesTotalPrice: 500
  ),
  ServicesModel(
    serviceName: 'Tyre Rotation',
    serviceId: '2',
    servicePrice: 800,
    serviceQuantity: 1,
    servicesTotalPrice: 800
  ),
  ServicesModel(
    serviceName: 'Oil Change',
    serviceId: '3',
    servicePrice: 1200,
    serviceQuantity: 1,
    servicesTotalPrice: 1200
  ),
  ServicesModel(
    serviceName: 'AC Refilling',
    serviceId: '4',
    servicePrice: 2500,
    serviceQuantity: 1,
    servicesTotalPrice: 2500,
  ),
];
