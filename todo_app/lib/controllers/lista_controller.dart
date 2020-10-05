import 'package:todo_app/models/Lista.dart';
import 'package:todo_app/repository/list_repository.dart';

class ListaController {
  List<Lista> list = new List<Lista>();
  ListRepository repository = new ListRepository();

  Future<void> getAll() async {
    try {
      final allList = await repository.readData();
      list.clear();
      list.addAll(allList);
    } catch(error){
      print("Erro: "+ error.toString());
    }
  }

  Future<void> create(Lista lista) async {
    try {
      list.add(lista);
      await update();
    } catch(error){
      print("Error " + error.toString());
    }
  }

  void update() async{
    await repository.saveData(list);
    await getAll();
  }

  Future<void> updateList(List<Lista> lista) async {
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