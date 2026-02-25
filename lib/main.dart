import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// macam2 type
String name = "ekik";
int number = 1;
double decimalNumber = 1.0;
List myList = ["isi 1", "isi 2", "isi 3"];

// key nya string isinya dinamik
Map<String, dynamic> myMap = {"Name": "Ekik", "Age": 22, "Hobby": "Reading"};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
          // kena masalah cross site ini aku pikirin nanti
          Image.network(
            "https://davedalessiowrites.wordpress.com/wp-content/uploads/2022/12/eva-pilot-00.jpeg",
          ),
      // Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Container(
      //     color: Colors.blue,
      //     // height: double.infinity,
      //     // width: double.infinity,
      //     // child: Column(
      //     child: Row(
      //       // bedanya child sama children? kalo child hanya bisa nampung 1 widget kalo children itu jamak jadi bisa nampung banyak widget
      //       // collums ini dia by default ngambil "at less as possible area"
      //       // kaya bilang eh aku mau "anak2 ku didalam sini rata tengah layar"

      //       // mainAxisAlignment: MainAxisAlignment.end,
      //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       // mainAxisSize: MainAxisSize.min,
      //       // crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Container(
      //           // kaya bilang eh tolong dong ambil seluruh tinggi dari parent, disini parentnya body dari scaffolds
      //           // disini aku remark karena kan kita pake collums? anggap aja gamungkin dong 1 kolom punya tinggi menuhin layar tapi ada kolom lain? jadinya "nimpa"
      //           // height: double.infinity,
      //           height: 100.0,
      //           width: 100.0,
      //           // margin: EdgeInsets.all(50.0),
      //           // padding: EdgeInsets.all(50.0),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(25.0),
      //             color: Colors.red,
      //           ),
      //           child: Center(child: Text("Kotak 1")),
      //         ),
      //         Container(
      //           // kaya bilang eh tolong dong ambil seluruh tinggi dari parent, disini parentnya body dari scaffolds
      //           // height: double.infinity,
      //           height: 100.0,
      //           width: 100.0,
      //           // margin: EdgeInsets.all(50.0),
      //           // padding: EdgeInsets.all(50.0),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(25.0),
      //             color: Colors.red,
      //           ),
      //           child: Center(child: Text("Kotak 2")),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
