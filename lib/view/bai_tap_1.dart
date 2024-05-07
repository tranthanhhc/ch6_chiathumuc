// man hinh thu 1 : nhập n , ĐK :
//data test - n = 113
import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/material.dart';

class Bai1 extends StatefulWidget {
  const Bai1({super.key});

  @override
  _Bai1State createState() => _Bai1State();
}
class _Bai1State extends State<Bai1> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nhập số phần tử ...'),
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          ElevatedButton(
            onPressed: () {
              String input = controller.text;
              int? n = int.tryParse(input);
              if(n != null) {
                // hiện loading
                Alert.showLoading(context);
                // set 1 giây sau hiển thị kết quả
                Future.delayed(const Duration(seconds: 1), () {
                  int result = baigiai1(n);
                  // ẩn loading
                  Navigator.of(context).pop();
                  //hiển thị kết quả
                  Alert.showIntResult(context,result);
                });
              }
              else {
                Future.delayed(const Duration(seconds: 1), () {
                  Alert.showErrorDialog(context,"Nhập một số nguyên hợp lệ");
                });
              }
            },
            child: const Text('Tính toán'),
          ),
        ],
      ),
    );
  }


}
int baigiai1(int n) {
  // Hàm decode để tìm số M từ số N
  int decode(int n) {
    String nStr = n.toString(); // Chuyển số n thành chuỗi

    // Khởi tạo chuỗi kết quả rỗng
    String result = '';

    // Lặp qua từng ký tự trong chuỗi nStr
    for (int i = 0; i < nStr.length;) {
      int count = 0; // Biến đếm số lần xuất hiện của ký tự hiện tại
      int j = i; // Lưu vị trí bắt đầu của đoạn liên tiếp các ký tự

      // Đếm số lần xuất hiện của ký tự hiện tại
      while (j < nStr.length && nStr[j] == nStr[i]) {
        count++;
        j++;
      }

      // Thêm số lần xuất hiện và ký tự vào chuỗi kết quả
      result += count.toString() + nStr[i];

      // Di chuyển chỉ số đến vị trí ký tự mới
      i = j;
    }
    // Chuyển chuỗi kết quả thành số nguyên và trả về
    return int.parse(result);
  }
  // Tìm số M từ số N
  int m = decode(n);
  // In ra số M
  return m;
}