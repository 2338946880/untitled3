import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//有一个number的全局状态，有三个Widget会使用到它，点击FloatingActionButton可以将number的值加1
void main() {
  val a = 0
  runApp(
    //将应用的顶层设置为ChangeNotifierProvider, 然后将MyApp()变为它的子Widget。
    ChangeNotifierProvider(
      create: (ctx) => NumberModel(),//ChangeNotifierProvider的create函数需要返回ChangeNotifier。
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    NumberModel model = Provider.of<NumberModel>(context);
    //有四个地方需要使用到共享的状态，三个显示文字的Text Widget和FloatingActionButton。
    return Scaffold(
        appBar: AppBar(
          title: Text("Provider"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [NumberWidget1(), NumberWidget1(), NumberWidget1()]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //FloatingActionButton也需要通过Provider.of<NumberModel>(context)方法先拿到NumberModel，然后调用set方法改变number的值。
            model.number++;
          },
          child: Icon(Icons.add),
        ));
  }
}

/**
 *ChangeNotifier是Flutter Framework的基础类，不是Provider库中的类。ChangeNotifier继承自Listenable,也就是ChangeNotifier可以通知观察者值的改变(实现了观察者模式)。
 */
class NumberModel extends ChangeNotifier {//将number封装到ChangeNotifier中，创建需要共享的状态

  int _number = 0;
  //NumberModel有一个_number状态，然后提供了获取的方法get和设置set的方法。
  int get number => _number;

  set number(int value) {
    _number = value;
    notifyListeners();
  }
}


class NumberWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取NumberModel的number
    int number = Provider.of<NumberModel>(context).number;
    //通过int number = Provider.of<NumberModel>(context).number;获取到NumberModel的number值，然后就可以显示了。
    return Container(
      child: Text(
        "点击次数: $number",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
