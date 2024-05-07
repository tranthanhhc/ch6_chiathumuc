// man hinh thu 7 : nhập n , ĐK : cơ số 10 không quá 20 chữ số và không có số 0 ở đầu
//data test - 16900278
import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Bai7 extends StatelessWidget {
  const Bai7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seven Screen'),),
      body: const InputNumber7(),
    );
  }
}
class InputNumber7 extends StatefulWidget {
  const InputNumber7({super.key});

  @override
  State<InputNumber7> createState() => _InputNumber7State();
}
class _InputNumber7State extends State<InputNumber7> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nhập N hệ cơ số 10'),
              keyboardType: TextInputType.number,
              maxLength: 20, // Giới hạn độ dài của số nhập vào không quá 20 chữ số
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              onChanged: (value) {
                if (value.isNotEmpty && value[0] == '0') {
                  _controller.text = value.substring(1);
                  _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: _controller.text.length));
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                String input = _controller.text;
                // Kiểm tra nếu chuỗi nhập vào không rỗng và không có số 0 ở đầu
                if (input.isNotEmpty && input[0] != '0') {
                  int n = int.tryParse(input) ?? 0;
                  // Kiểm tra n có nằm trong khoảng từ 1 đến 99999999999999999999 không
                  if (n > 0) {
                    Alert.showLoading(context);
                    Future.delayed(const Duration(seconds: 1), () {
                      String result = baigiai7(n);
                      // ẩn loading
                      Navigator.of(context).pop();
                      //hiển thị kết quả
                      Alert.showStringResult(context,result);
                    });
                  } else {
                    setState(() {
                      const Text('N không hợp lệ');
                    });
                  }
                } else {
                  setState(() {
                    const Text('N không hợp lệ');
                  });
                }
              },
              child: const Text('Kết quả'),
            ),
          ],
        ),
      ),
    );
  }

}
String baigiai7(int n) {

  // Hàm kiểm tra số có chia hết cho 3 không
  bool chiaHetCho3(int number) {
    return number % 3 == 0;
  }

  // Hàm tạo tập D và đếm số lượng số chia hết cho 3
  String createSetD(int n) {
    // tạo ds set
    Set<int> setD = {};
    int demChiaHetCho3 = 0;
    String rs = '';

    // Thêm số n vào tập D
    setD.add(n);
    // convert n sang chuỗi để có thể thao tác xóa
    String nStr = n.toString();

    // Tạo các số mới bằng cách xóa một hoặc một vài chữ số liên tiếp của n
    for (int i = 0; i < nStr.length; i++) {
      for (int j = i + 1; j <= nStr.length; j++) {
        //lấy chuỗi n của i và j để tạo chuỗi mới
        String newNumberStr = nStr.substring(0, i) + nStr.substring(j);
        // Kiểm tra chuỗi mới tạo ra có hợp lệ không trước khi chuyển đổi
        if (newNumberStr.isNotEmpty && newNumberStr != '0') {
          int newNumber = int.parse(newNumberStr);
          // Kiểm tra số mới không trùng với số n
          if (!setD.contains(newNumber)) {
            setD.add(newNumber);
            rs += '$newNumber, ';
          }
        }
      }
    }

    // Kiểm tra số mới có chia hết cho 3 không và đếm số lượng số chia hết cho 3
    // duyệt các phần tử trong mảng set
    for (int number in setD) {
      if (chiaHetCho3(number)) {
        demChiaHetCho3++;
      }
    }

    // In ra màn hình các số chia hết cho 3 và số lượng số chia hết cho 3
    print("Các số chia hết cho 3 trong tập D:");
    for (int number in setD) {
      if (chiaHetCho3(number)) {
        print(number);
      }
    }
    return 'Số lượng số chia hết cho 3 trong tập D: $demChiaHetCho3\n'
        'Chi tiết các số : ${rs.substring(0, rs.length)}';
  }

  // Gọi hàm tạo tập D
  return createSetD(n);
}
