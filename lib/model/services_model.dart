class ServicesModel {
  final String serviceName;
  final String serviceId;
  ServicesModel({required this.serviceName, required this.serviceId});
}

final List<ServicesModel> servicesEx = [
  ServicesModel(serviceName: 'Car Wash', serviceId: '1'),
  ServicesModel(serviceName: 'Oil Pump', serviceId: '2'),
  ServicesModel(serviceName: 'Oil Change', serviceId: '3'),
];
