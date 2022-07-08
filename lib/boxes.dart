import 'package:rekrutacja/barcode.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<BarCode> getCodes() => Hive.box<BarCode>('barCode');
}
