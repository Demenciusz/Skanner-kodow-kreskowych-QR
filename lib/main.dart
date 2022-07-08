import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rekrutacja/barcode.dart';
import 'package:rekrutacja/barcodescanner.dart';
import 'package:rekrutacja/boxes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BarCodeAdapter());
  await Hive.openBox<BarCode>('barCode');
  runApp(const MyApp());
}

final List<BarCode> barCodeList = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/scann': (context) => const BarCodeScanner()},
      title: 'Rekrutacja',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ValueListenableBuilder<Box<BarCode>>(
                valueListenable: Boxes.getCodes().listenable(),
                builder: (context, box, _) {
                  final barCodeList = box.values.toList().cast<BarCode>();
                  return barCodeCreator(barCodeList);
                }),
            SizedBox(
              width: 100,
              height: 50,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text(
                  'Scann',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/scann');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget barCodeCreator(List<BarCode> barCodeList) {
    if (barCodeList.isEmpty) {
      return const Center(
        child: Text('Nie zapisano żadnego kodu'),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: barCodeList.length,
          itemBuilder: (context, index) {
            String barCodeValue = barCodeList[index].barCodeValue;
            String scanDate = barCodeList[index].scanDate;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Code: '),
                Text(
                  '$barCodeValue ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Data: '),
                Text('$scanDate ', style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () {
                      deleteBarCode(barCodeList[index]);
                    },
                    icon: const Icon(Icons.close))
              ],
            );
          },
        ),
      );
    }
  }

//Usuwanie
  void deleteBarCode(BarCode barCode) {
    barCode.delete();
  }
}
