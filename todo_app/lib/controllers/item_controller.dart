import 'package:todo_app/models/Item.dart';
import 'package:todo_app/repository/item_repository.dart';

class ItemController {
  List<Item> list = new List<Item>(); //herdando o model
  ItemRepository repository = new ItemRepository();

  Future<void> getAll() async {
    try {
      final allList = await repository.readData();
      list.clear();
      list.addAll(allList);
    } catch(error){
      print("Erro: "+ error.toString());
    }
  }

  Future<void> create(Item item) async {
    try {
      list.add(item);
      await update();
    } catch(error){
      print("Error " + error.toString());
    }
  }

  void update() async{
    await repository.saveData(list);
    await getAll();
  }

  Future<void> updateList(List<Item> lista) async {
    await repository.saveData(lista);
    await getAll();
  }

  Future<void> delete(int id) async {
    try{
      list.removeAt(id);
      await update();
    } catch(error) {
      print("Error " + error.toString());
    }
  }

}