import 'package:flutter/material.dart';
import 'package:todo_app/controllers/item_controller.dart';
import 'package:todo_app/models/Item.dart';

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  var _controller = ItemController();
  var _lista = List<Item>();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll().then((data) {
        setState(() {
          _lista = _controller.list;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      backgroundColor: Color(0xFAFAFAFF),
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
              title: Text(_lista[i].descricao),
              secondary: IconButton(
                icon: Icon(Icons.backspace),
                onPressed: () {
                  _controller.delete(i);
                  setState(() {
                    _lista = _controller.list;
                  });
                },
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (response) {
                setState(() {
                  _lista[i].concluido = response;
                });
                _controller.updateList(_lista);
              },
              value: _lista[i].concluido,
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
                  _controller.create(Item(descricao: _itemController.text.toString(), concluido: false));
                  setState(() {
                    _lista = _controller.list;
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