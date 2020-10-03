import 'package:flutter/material.dart';

class ListView extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
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
              child: ListView(
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
              ),
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

  Widget buildListComponent(context) {
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