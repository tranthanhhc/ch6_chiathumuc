// man hinh thu 3 : mảng n, ĐK :
// data test -list =5,7,2,9,10,15
import 'dart:math';

import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bai3 extends StatelessWidget {
  const Bai3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Third Screen'),),
      body: const InputNumbers(),
    );
  }
}
class InputNumbers extends StatefulWidget {
  const InputNumbers({super.key});

  @override
  State<InputNumbers> createState() => _InputNumbersState();
}
class _InputNumbersState extends State<InputNumbers> {
  final TextEditingController _controller = TextEditingController();
  List<int> numbers = [];
  int maxNums = 6;
  //String inputList = '';

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
              style: const TextStyle(color: Colors.lightBlueAccent,fontSize: 28),
              children: [
                const TextSpan(
                  text:'Mảng nhập vào \n',
                ),
                TextSpan(
                  text: numbers.toString(),
                  style: const TextStyle(color: Colors.deepOrange,fontStyle: FontStyle.italic,),

                ),
              ]
            ),

          ),
          TextFormField(
            // //onChanged: (v) {
            //   inputList = v;
            // },
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nhập từng số vào mảng ( max 6 phần tử )'),
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          ElevatedButton(
            onPressed: _addCompetition,
            child: const Text('Thêm số'),
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          ElevatedButton(
            onPressed: () {
              Alert.showLoading(context);
              Future.delayed(const Duration(seconds: 1), () {
                //numbers = inputList.split(' ').map((string) => int.parse(string)).toList();
                String result = baigiai3(numbers);
                // ẩn loading
                Navigator.of(context).pop();
                //hiển thị kết quả
                Alert.showStringResult(context,result);
                setState(() {
                  numbers.clear();
                });
              });
            },
            child: const Text('Tính Toán'),),
        ],
      ),

    );
  }
  void _addCompetition() {
    final controllerText = _controller.text.trim();
    int? n = int.tryParse(controllerText);
    if (n != null && numbers.length < maxNums) {
      setState(() {
        numbers.add(n);
        _controller.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Số $n đã được thêm vào danh sách.'),
          )
      );
    } else {
      Alert.showErrorDialog(context, 'Sai điều kiện , mời nhập lại');
    }
  }
}
String baigiai3(List<int> numbers) {
  // Hàm tính giai thừa của một số
  int giaithua(int n) {
    if (n == 0 || n == 1) {
      return 1;
    } else {
      return n * giaithua(n - 1);
    }
  }

  // Hàm kiểm tra số nguyên tố
  bool ktnguyento(int n) {
    if (n <= 1) {
      return false;
    }
    for (int i = 2; i <= sqrt(n); i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }

  // Hàm tính số Fibonacci thứ n
  int fibonacci(int n) {
    if (n <= 1) {
      return n;
    }
    int fib = 1;
    int prevFib = 1;
    for (int i = 2; i <= n; i++) {
      int temp = fib;
      fib += prevFib;
      prevFib = temp;
    }
    return fib;
  }

  // Sort danh sách theo thứ tự giảm dần
  numbers.sort((a, b) => b.compareTo(a));

  // Lấy số lớn thứ hai
  int? secondLargest = numbers.length > 1 ? numbers[1] : null;

  if (secondLargest == null) {
    return "Không có số lớn thứ hai.";
  } else {
    String parity = secondLargest.isEven ? "Chẵn" : "Lẻ";
    bool prime = ktnguyento(secondLargest);
    int factorial = giaithua(secondLargest);
    int fib = fibonacci(secondLargest);

    return 'Số lớn thứ hai là: $secondLargest\n'
        'Đây là số: $parity\n'
        'Số này ${prime ? "là" : "không phải"} số nguyên tố\n'
        'Giai thừa của $secondLargest là: $factorial\n'
        'Số Fibonacci thứ $secondLargest là: $fib';
  }
}
