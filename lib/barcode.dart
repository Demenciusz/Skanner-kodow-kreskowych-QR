import 'package:hive_flutter/adapters.dart';
part 'barcode.g.dart';

@HiveType(typeId: 0)
class BarCode extends HiveObject {
  @HiveField(0)
  String barCodeValue;
  @HiveField(1)
  String scanDate;
  BarCode({required this.barCodeValue, required this.scanDate});
}
