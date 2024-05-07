import 'package:ch6_real_exercise/constant/app_string.dart';
import 'package:ch6_real_exercise/view/bai_tap_1.dart';
import 'package:ch6_real_exercise/view/bai_tap_2.dart';
import 'package:ch6_real_exercise/view/bai_tap_3.dart';
import 'package:ch6_real_exercise/view/bai_tap_4.dart';
import 'package:ch6_real_exercise/view/bai_tap_5.dart';
import 'package:ch6_real_exercise/view/bai_tap_6.dart';
import 'package:ch6_real_exercise/view/bai_tap_7.dart';
import 'package:ch6_real_exercise/view/bai_tap_8.dart';
import 'package:flutter/material.dart';

// danh sach cac man hinh (key, man hinh)
final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const Giaibaitap(),
  '/first' : (context) =>  const Bai1(),
  '/second': (context) => const Bai2(),
  '/third' : (context) =>  const Bai3(),
  '/four' : (context) =>  const Bai4(),
  '/five' : (context) =>  const Bai5(),
  '/six' : (context) =>  const Bai6(),
  '/seven' : (context) =>  const Bai7(),
  '/eight' : (context) =>  const Bai8(),
};

void main() {
  runApp(const MyApp());
}

// class chinh
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Example',
      initialRoute: '/',
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
// man hinh dau tien
class Giaibaitap extends StatelessWidget {
  const Giaibaitap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giải bài tập')),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildColumn(context),
          ),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildElevatedButton(context,AppString.example_1,'/first'),
        const Padding(padding: EdgeInsets.all(16.0)),
        buildElevatedButton(context,AppString.example_2,'/second'),
        const Padding(padding: EdgeInsets.all(16.0)),
        buildElevatedButton(context,AppString.example_3,'/third'),
        const Padding(padding: EdgeInsets.all(16.0)),
        buildElevatedButton(context,AppString.example_4,'/four'),
        const Padding(padding: EdgeInsets.all(16.0)),
        buildElevatedButton(context,AppString.example_5,'/five'),
        const Padding(padding: EdgeInsets.all(16.0)),
        buildElevatedButton(context,AppString.example_6,'/six'),
        const Padding(padding: EdgeInsets.all(16.0)),
        buildElevatedButton(context,AppString.example_7,'/seven'),
        const Padding(padding: EdgeInsets.all(16.0)),
        buildElevatedButton(context,AppString.example_8,'/eight'),
        const Padding(padding: EdgeInsets.all(16.0)),
      ],
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context,String buttonText,String routerName) {
    return ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, routerName);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Kích thước tối thiểu của nút
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.white,
          ),
        child: Text(buttonText),

      );
  }
}

