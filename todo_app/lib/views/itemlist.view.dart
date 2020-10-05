import 'package:flutter/material.dart';
import 'package:todo_app/controllers/lista_controller.dart';
import 'package:todo_app/controllers/item_controller.dart';
import 'package:todo_app/models/Lista.dart';
import 'package:todo_app/models/Item.dart';

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final _formKey = GlobalKey<FormState>();
  var _listaTextController = TextEditingController();
  var _itemTextController = TextEditingController();
  var _listaController = ListaController();
  var _itemController = ItemController();
  var _lista = List<Lista>();
  var _itemLista = List<Item>();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listaController.getAll().then((data) {
        setState(() {
          _lista = _listaController.list;
        });
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _itemController.getAll().then((data) {
        setState(() {
          _itemLista = _itemController.list;
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
                onPressed: () => _showDialogList(context),
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
    return Column(
      children: <Widget>[
        for (int i = 0; i < _lista.length; i++)
          ExpansionTile(
            title: Container(
              child: Dismissible(
                key: Key(_lista[i].Nome),
                onDismissed: (direction) {
                  _listaController.delete(i);
                  setState(() {
                    _lista = _listaController.list;
                    _listaTextController.text = "";
                  });
                },
                child: ListTile(
                  title: Text(_lista[i].Nome, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  trailing: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _showDialog(context, i),
                      ),
                    ],
                  ),
                ),
                background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment(-0.9, 0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
            ),
            children: <Widget>[
              _buildListComponentTeste(context, i),
            ],
          ),

      ],
    );
  }

  Widget _buildListComponentTeste(context, int id_lista) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _itemLista.length; i++)
          if(_itemLista[i].id_list == id_lista)
            Dismissible(
              key: Key(_itemLista[i].descricao),
              child: Card(
                borderOnForeground: true,
                shadowColor: Colors.black,
                elevation: 6,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: CheckboxListTile(
                  title: Text(_itemLista[i].descricao),
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (response) {
                    setState(() {
                      _itemLista[i].concluido = response;
                    });
                    _itemController.updateList(_itemLista);
                  },
                  value: _itemLista[i].concluido,
                ),
              ),
              onDismissed: (direction) {
                _itemController.delete(i);
                setState(() {
                  _itemLista = _itemController.list;
                  _itemTextController.text = "";
                });
              },
              background: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildListComponent(context) {
    return ListView(
      children: <Widget>[
        for (int i = 0; i < _itemLista.length; i++)
          Card(
            borderOnForeground: true,
            shadowColor: Colors.black,
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: CheckboxListTile(
              title: Text(_itemLista[i].descricao),
              secondary: IconButton(
                icon: Icon(Icons.backspace),
                onPressed: () {
                  _itemController.delete(i);
                  setState(() {
                    _itemLista = _itemController.list;
                  });
                },
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (response) {
                setState(() {
                  _itemLista[i].concluido = response;
                });
                _itemController.updateList(_itemLista);
              },
              value: _itemLista[i].concluido,
            ),
          ),
      ],
    );
  }

  _showDialog(context, int id_lista)  {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _itemTextController,
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
                  _itemController.create(Item(descricao: _itemTextController.text.toString(),
                      concluido: false,
                      id_list: id_lista,
                  ));
                  setState(() {
                    _itemLista = _itemController.list;
                    _itemTextController.text = "";
                  });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showDialogList(context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _listaTextController,
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
                  _listaController.create(Lista(Nome: _listaTextController.text));
                setState(() {
                  _lista = _listaController.list;
                  _listaTextController.text = "";
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