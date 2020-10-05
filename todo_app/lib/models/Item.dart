class Item {
  String descricao;
  bool concluido;

  Item({ this.descricao, this.concluido });

  Item.FromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido;
    return data;
  }

}