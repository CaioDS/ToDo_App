import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  List _lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: _body(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body() {
    return Scrollbar(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Container(
              child: buildListComponent(),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: FloatingActionButton(
                onPressed: () => _showDialog(context),
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListComponent() {
    return ListView(
      children: <Widget>[
        for (int i = 0; i < _lista.length; i++)
          Container(
            height: 60,
            width: 20,
            decoration: BoxDecoration(
              border: Border.all(width: 3),
              color: Colors.grey,
            ),
            child: ListTile(
              leading: Icon(Icons.map),
              title: Text(_lista[i].toString()),
              onLongPress: () {
                setState(() {

                });
              },
            ),
          ),
      ],
    );
  }

  _showDialog(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _itemController,
              validator: (s) {
                if(s.isEmpty)
                  return "Digite o item.";
                else
                  return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Item"),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Adicionar",
                style: TextStyle(color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if(_formKey.currentState.validate())
                  setState(() {
                    _lista.add(_itemController.text);
                    _itemController.text = "";
                  });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },

    );
  }

}
