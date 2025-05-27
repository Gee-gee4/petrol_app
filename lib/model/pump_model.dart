class PumpModel {
  final String pumpName;
  final String pumpId;

  PumpModel({required this.pumpName, required this.pumpId});
}
final List<PumpModel> pumps = [
  PumpModel(pumpName: "Pump 1", pumpId: "001"),
  PumpModel(pumpName: "Pump 2", pumpId: "002"),
  PumpModel(pumpName: "Pump 3", pumpId: "003"),
  PumpModel(pumpName: "Pump 4", pumpId: "004"),
  PumpModel(pumpName: "Pump 5", pumpId: "005"),
  PumpModel(pumpName: "Pump 6", pumpId: "006"),
];