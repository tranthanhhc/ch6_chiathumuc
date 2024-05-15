// man hinh thu 6 : nhập a và b , ĐK : 10^4 <= A < B < 10^5
// data test - A: 11111,B: 22222
import 'dart:math';

import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/material.dart';

class Bai6 extends StatelessWidget {
  const Bai6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Six Screen'),),
      body: const InputNumber6(),
    );
  }
}
class InputNumber6 extends StatefulWidget {
  const InputNumber6({super.key});

  @override
  State<InputNumber6> createState() => _InputNumber6State();
}
class _InputNumber6State extends State<InputNumber6> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
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
              decoration: const InputDecoration(labelText: 'Nhập biển số A'),
              keyboardType: TextInputType.number,
            ),
            const Padding(padding: EdgeInsets.all(16.0),),
            TextFormField(
              controller: _controllerB,
              decoration: const InputDecoration(labelText: 'Nhập biển số B '),
              keyboardType: TextInputType.number,
            ),
            const Padding(padding: EdgeInsets.all(16.0),),
            ElevatedButton(
              onPressed: () {
                int a = int.tryParse(_controllerA.text) ?? 0;
                int b = int.tryParse(_controllerB.text) ?? 0;
                if( a > b ) {
                  Alert.showErrorDialog(context, 'Sai điều kiện , mời nhập lại');
                } else {
                  Alert.showLoading(context);
                  baigiai6(a, b).then((value) {
                    Navigator.of(context).pop();
                    //hiển thị kết quả
                    Alert.showStringResult(context,value);
                  });
                }
              },
              child: const Text('Tính Toán'),
            ),
          ],
        ),
      ),
    );
  }

}
Future<String> baigiai6(int A, int B) async {
  // Hàm kiểm tra số nguyên tố
  bool ktnguyento(int n) {
    // ít hơn 2 phần tử thì không phải snt
    if (n < 2) return false;
    for (int i = 2; i <= sqrt(n); i++) {
      // chia hết cho n cũng k phải snt
      if (n % i == 0) return false;
    }
    return true;
  }

  // Hàm kiểm tra số đối xứng
  bool ktdoixung(int n) {
    // chuyển dãy số n qua chuỗi để xem xét từng con số
    String nStr = n.toString();
    // lưu dộ dài chuỗi vào biến length
    int length = nStr.length;
    // chạy qua 1 nữa chuỗi
    for (int i = 0; i < length / 2; i++) {
      //nếu chữ số i bên trái khác vs chữ số thứ i bên phải thì trả về false
      if (nStr[i] != nStr[length - i - 1]) return false;
    }
    return true;
  }
  String rs = '';
  // Hàm đếm số lượng biển số xe đẹp trong đoạn từ A đến B
  int soluongbiendep(int A, int B) {
    int count = 0;
    // tạo ds biển đẹp để lưu vào
    List<int> bienDep = [];

    for (int i = A; i <= B; i++) {
      // nếu i thõa là snt và là số đối xứng
      if (ktnguyento(i) && ktdoixung(i)) {
        rs += '$i, ';
        // tăng biến đếm
        count++;
        // đưa vào list
        bienDep.add(i);
      }
    }
    return count;
  }

  int result = soluongbiendep(A, B);
  return 'Số lượng biển đẹp là : $result\n'
      'Chi tiết các biển đẹp : ${rs.substring(0, rs.length )}';
}

