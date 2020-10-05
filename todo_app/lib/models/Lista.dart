class Lista {
  String Nome;

  Lista({ this.Nome });

  Lista.FromJson(Map<String, dynamic> json) {
    Nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.Nome;
    return data;
  }

}