class Item {
  String descricao;
  bool concluido;
  int id_list;

  Item({ this.descricao, this.concluido, this.id_list });

  Item.FromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    concluido = json['concluido'];
    id_list = json['id_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido;
    data['id_list'] = this.id_list;
    return data;
  }

}