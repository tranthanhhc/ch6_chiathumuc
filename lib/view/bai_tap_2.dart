// man hinh thu 2 : nhập a và b ,ĐK:
//data test - A = 1, B = 20
import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/material.dart';

class Bai2 extends StatefulWidget {
  const Bai2({super.key});

  @override
  _Bai2State createState() => _Bai2State();
}
class _Bai2State extends State<Bai2> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controllerA,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nhập giá trị A'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controllerB,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nhập giá trị B'),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              onPressed: () {
                int a = int.tryParse(_controllerA.text) ?? 0;
                int b = int.tryParse(_controllerB.text) ?? 0;
                if( a <= 0 || b <= 0 ) {
                  Future.delayed(const Duration(seconds: 1), () {
                    Alert.showErrorDialog(context, ' Số nhập vào không hợp lệ');
                  });
                } else {
                  Alert.showLoading(context);
                  // set 1 giây sau hiển thị kết quả
                    baigiai2(a, b).then((value) {
                      Navigator.of(context).pop();
                      //hiển thị kết quả
                      Alert.showStringResult(context,value);
                    });
                }
              },
              child: const Text('Tính toán '),
            ),
          ],
        ),
      ),
    );
  }
}
Future<String> baigiai2( int a, int b) async {
  int count = 0;
  int sum = 0;
  String rs = '';
  // chạy từ a -> b
  for (int i = a; i < b; i++) {
    // chia hết cho 2 là số chẵn và chia hết cho 3
    if (i % 2 == 0 && i % 3 == 0) {
      rs +='$i, ';
      // thực hiện đếm khi có i đặt điều kiện
      count++;
      // tính tổng số i đạt điều kiện
      sum += i;
    }
  }
  return 'Cac so chia het cho 3 tu $a den $b la : ${rs.substring(0, rs.length - 2)}\n '
      'So luong cac so chia het cho 3 la : $count \n '
      'Tong cac so chia het cho 3 la : $sum';
}

