import 'package:flutter/material.dart';

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  List _lista = [];
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      backgroundColor: Colors.white70,
      body: _body(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  @override
  Widget _body() {
    return Scrollbar(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Container(
              child: buildListComponent(context),
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
          Card(
            borderOnForeground: true,
            shadowColor: Colors.black,
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: CheckboxListTile(
              title: Text(_lista[i].toString()),
              secondary: IconButton(
                icon: Icon(Icons.backspace),
                onPressed: () {
                  setState(() {
                    _lista.removeAt(i);
                  });
                },
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (response) {
                setState(() {
                  checkedValue = response;
                  print(checkedValue);
                });
              },
              value: checkedValue,
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