
// man hinh thu 8 : mảng x va y , ĐK : 0 <= x <= 10^7, 0 <= y <= 1000
// data test - A : 0, 100, 0, 700, 0, 500 B :1, 2, 3, 2, 3, 4, 3, 4, 5
import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/material.dart';

class Bai8 extends StatelessWidget {
  const Bai8({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eight Screen'),),
      body: const InputNumber8(),
    );
  }
}
class InputNumber8 extends StatefulWidget {
  const InputNumber8({super.key});

  @override
  State<InputNumber8> createState() => _InputNumber8State();
}
class _InputNumber8State extends State<InputNumber8> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  List<int> AL = [];
  List<int> BL = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controllerA,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nhập mảng A (VD: 1 -> Thêm số)'),
            ),
            const Padding(padding: EdgeInsets.all(16.0),),
            TextFormField(
              controller: _controllerB,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nhập mảng B (VD: 1 -> Thêm số) '),
            ),
            const Padding(padding: EdgeInsets.all(16.0),),
            ElevatedButton(
              onPressed: _addAL,
              child: const Text('Thêm vào A'),
            ),
            const Padding(padding: EdgeInsets.all(16.0),),

            ElevatedButton(
              onPressed: _addBL,
              child: const Text('Thêm vào B'),
            ),
            const Padding(padding: EdgeInsets.all(16.0),),
            ElevatedButton(
              onPressed: _calculateTotal,
              child: const Text('Tính tiền'),
            ),
          ],
        ),
      ),
    );
  }
  void _addAL() {
    final competitionText = _controllerA.text.trim();
    final List<int> times = competitionText.split(',').map(int.parse).toList();
    setState(() {
      AL.addAll(times);
      _controllerA.clear();
    });
  }
  void _addBL() {
    final competitionText = _controllerB.text.trim();
    final List<int> times = competitionText.split(',').map(int.parse).toList();
    setState(() {
      BL.addAll(times);
      _controllerB.clear();
    });
  }
  void _calculateTotal() {
    if (AL.isEmpty || BL.isEmpty || AL.length != 6 || BL.length != 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$AL hoặc $BL bị nhập sai '),
        ),
      );
      return;
    } else {
      Alert.showLoading(context);
      Future.delayed(const Duration(seconds: 2), () {
        final result = baigiai8(AL, BL);
        Navigator.of(context).pop();
        Alert.showStringResult(context,result);
      });

    }
  }

}
String baigiai8(List<int> chiSoDien,List<int> giaDien ) {

  int X1 = chiSoDien[0];
  int Y1 = chiSoDien[1];
  int X2 = chiSoDien[2];
  int Y2 = chiSoDien[3];
  int X3 = chiSoDien[4];
  int Y3 = chiSoDien[5];

  int A1 = giaDien[0];
  int B1 = giaDien[1];
  int C1 = giaDien[2];
  int A2 = giaDien[3];
  int B2 = giaDien[4];
  int C2 = giaDien[5];
  int A3 = giaDien[6];
  int B3 = giaDien[7];
  int C3 = giaDien[8];

  int dientieudung = 0;
  int diensanxuat = 0;
  int dienkinhdoanh = 0;
  // 50kw đầu tiên : A1 đồng
  if (Y1 <= 50) {
    dientieudung += Y1 * A1;
    // 51 <= n <= 150 tiếp theo : B1 đồng
  } else if (Y1 <= 150) {
    dientieudung += 50 * A1 + (Y1 - 50) * B1;
    // n > 150 : C1 đồng
  } else {
    dientieudung += 50 * A1 + 100 * B1 + (Y1 - 150) * C1;
  }
  // 200kw đầu tiên : A2 đồng
  if (Y2 <= 200) {
    diensanxuat += Y2 * A2;
    // 201 <= n <= 1000 tiếp theo : B2 đồng
  } else if (Y2 <= 1000) {
    diensanxuat += 200 * A2 + (Y2 - 200) * B2;
    // n > 1000 : C2 đồng
  } else {
    diensanxuat += 200 * A2 + 800 * B2 + (Y2 - 1000) * C2;
  }
  // 100kw đầu tiên : A2 đồng
  if (Y3 <= 100) {
    dienkinhdoanh += Y3 * A3;
    // 101 <= n <= 200 tiếp theo : B2 đồng
  } else if (Y3 <= 200) {
    dienkinhdoanh += 100 * A3 + (Y3 - 100) * B3;
    // n > 200 : C2 đồng
  } else {
    dienkinhdoanh += 100 * A3 + 100 * B3 + (Y3 - 200) * C3;
  }

  int tongtien = dientieudung + diensanxuat + dienkinhdoanh;

  return 'tong tien dien phai tra : $tongtien';
}


