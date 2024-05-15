// man hinh thu 5 : số  nguyên  n , mang kep i j ,Đk : n < 1000 , 0 <= i < j < 70000
// data test - n = 5, list :0,2 ; 1,2 ; 3,4; 2,5; 4,5
import 'package:ch6_real_exercise/widget/alert.dart';
import 'package:flutter/material.dart';

class Bai5 extends StatelessWidget {
  const Bai5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Five Screen'),),
      body: const InputNumers3(),
    );
  }
}
class InputNumers3 extends StatefulWidget {
  const InputNumers3({super.key});

  @override
  State<InputNumers3> createState() => _InputNumers3State();
}
class _InputNumers3State extends State<InputNumers3> {
  final TextEditingController _nController = TextEditingController();
  final TextEditingController _competitionController = TextEditingController();
  List<List<int>> competitions = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    text: competitions.toString(),
                    style: const TextStyle(color: Colors.deepOrange,fontStyle: FontStyle.italic,),
                  ),
                ]
            ),
          ),
          TextFormField(
            controller: _nController,
            decoration: const InputDecoration(labelText: 'Nhập N (số lượng cuộc thi)'),
            keyboardType: TextInputType.number,
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          TextFormField(
            controller: _competitionController,
            decoration: const InputDecoration(labelText: 'Nhập thời điểm bắt đầu và kết thúc(VD: 1,2 -> Thêm số)'),
          ),
          const Padding(padding: EdgeInsets.all(16.0),),

          ElevatedButton(
            onPressed: _addCompetition,
            child: const Text('Thêm số'),
          ),
          const Padding(padding: EdgeInsets.all(16.0),),
          ElevatedButton(
            onPressed: _calculateRooms,
            child: const Text('Chia phòng'),
          ),
        ],
      ),
    );
  }

  void _addCompetition() {
    final competitionText = _competitionController.text.trim();
    final List<int> times = competitionText.split(',').map(int.parse).toList();
    bool isValid = true;
    for ( int time in times) {
      if ( time == null || time < 0 || time > 70000) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Số $time sai điều kiện ( >0 và <70000.'),
              duration: const Duration(milliseconds: 500),
            )
        );
        isValid = false;
        break;
      } else {
        setState(() {
          competitions.add(times);
          _competitionController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Số $time đã được thêm vào danh sách.'),
              duration: const Duration(milliseconds: 500),

            )
        );
      }
    }
  }
  void _calculateRooms() {
    final int N = int.tryParse(_nController.text.trim()) ?? 0;
    if (N <= 0 && N != null && N < 1000) {
      _showErrorMessage('Invalid Input', 'Please enter a valid number of competitions (N > 0)');
      return;
    }
    if (competitions.length < N) {
      _showErrorMessage('Incomplete Input', 'Please enter all competition start and end times');
      return;
    }
    Alert.showLoading(context);
    baigiai5(N, competitions).then((value) {
      Navigator.of(context).pop();
      Alert.showStringResult(context,value);
    });
  }
  void _showErrorMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
Future<String> baigiai5 ( int N,List<List<int>> competitions ) async {
  // Số lượng cuộc thi cứng là 5

  // Thời gian bắt đầu và kết thúc của mỗi cuộc thi

  // Sắp xếp các cuộc thi theo thời gian kết thúc tăng dần
  competitions.sort((a, b) => a[1].compareTo(b[1]));

  // Khởi tạo biến đếm số phòng cần thiết
  int phong = 0;

  // Mảng rooms để lưu thời gian kết thúc của từng phòng
  List<int> rooms = [];

  // Duyệt qua từng cuộc thi
  for (int i = 0; i < N; i++) {
    bool foundRoom = false;
    // Duyệt qua từng phòng
    for (int j = 0; j < rooms.length; j++) {
      // Nếu có phòng trống, cập nhật lại thời gian kết thúc của phòng
      if (rooms[j] <= competitions[i][0]) {
        rooms[j] = competitions[i][1];
        foundRoom = true;
        break;
      }
    }
    // Nếu không có phòng trống, tăng biến đếm số phòng cần thiết lên 1 và thêm một phòng mới
    if (!foundRoom) {
      phong++;
      rooms.add(competitions[i][1]);
    }
  }
  return 'so luong phong can thiet la : $phong';
}

