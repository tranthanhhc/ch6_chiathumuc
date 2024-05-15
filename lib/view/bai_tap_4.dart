// man hinh thu 4 : số nguyên  n va mảng i , ĐK : 1 < n <= 106, 1 <= i <= 109, i = 1/n
// data test - n = 6, list :18,8,6,13,14,28
import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/material.dart';

class Bai4 extends StatelessWidget {
  const Bai4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Four Screen'),),
      body: const InputNumbers2(),
    );
  }
}
class InputNumbers2 extends StatefulWidget {
  const InputNumbers2({super.key});

  @override
  State<InputNumbers2> createState() => _InputNumbers2State();
}
class _InputNumbers2State extends State<InputNumbers2> {
  final TextEditingController _nController = TextEditingController();
  final TextEditingController _roadController = TextEditingController();
  List<int> dis = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(color: Colors.lightBlueAccent,fontSize: 28,),
                children: [
                  const TextSpan(
                    text:'Mảng nhập vào \n',
                  ),
                  TextSpan(
                    text: dis.toString(),
                    style: const TextStyle(color: Colors.deepOrange,fontStyle: FontStyle.italic,),
                  ),
                ]
            ),
          ),
          TextFormField(
            controller: _nController,
            decoration: const InputDecoration(labelText: 'Nhập N (đoạn đường)'),
            keyboardType: TextInputType.number,
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          TextFormField(
            controller: _roadController,
            decoration: const InputDecoration(labelText: 'Nhập từng số vào mảng'),
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          ElevatedButton(
            onPressed: _addCompetition,
            child: const Text('Thêm số'),
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          ElevatedButton(
            onPressed: () {
              int n = int.tryParse(_nController.text) ?? 0;
              if( n > 1 && n < 106) {
                Alert.showLoading(context);
                Future.delayed(const Duration(seconds: 1), () {
                baigiai4(n, dis).then((value) {
                  // ẩn loading
                  Navigator.of(context).pop();
                  //hiển thị kết quả
                  Alert.showStringResult(context,value);
                });
                });
              } else {
                Alert.showErrorDialog(context, 'Sai điều kiện , mời nhập lại');
              }
            },
            child: const Text('Tính Toán'),
          ),
        ],
      ),
    );
  }
  void _addCompetition() {
    final roadText = _roadController.text.trim();
    final List<int> times = roadText.split(',').map(int.parse).toList();
    bool isValid = true;
    for ( int time in times) {
      if ( time == null || time < 1 || time > 109) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Số $time sai điều kiện ( >1 và <109.'),
            )
        );
        isValid = false;
        break;
      } else {
        setState(() {
          dis.addAll(times);
          _roadController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 500),
              content: Text('Số $time đã được thêm vào danh sách.'),
            )
        );
      }
    }
  }
}
Future<String> baigiai4(int n,List<int> distances) async{
  // sắp xếp theo thú tự tăng dần
  distances.sort();

  // biến h là độ lệch giữa di và dj - cụ thể là đoạn đường đâu tiên trong dãy
  int H = distances[1] - distances[0];
  int index = 0; // Lưu vị trí của đoạn đường có độ lệch nhỏ nhất
  // duyệt từ phần tử thứ 3 (distances[1]) đến n-1
  for (int i = 2; i < n; i++) {
    // tính độ lệch mới của phần từ duyệt qua
    int newH = distances[i] - distances[i - 1];
    // nếu thấy nhỏ hơn biến H , th cập nhập lại
    if (newH < H) {
      H = newH;
      index = i - 1; // Cập nhật vị trí của đoạn đường có độ lệch nhỏ nhất
    }
  }
  return 'Đoạn đường có độ lệch nhỏ nhất là từ ${distances[index]} đến ${distances[index + 1]} \n'
      'Độ lệch của hai đoạn đường có tình trạng giao thông giống nhau nhất là: $H';
}
