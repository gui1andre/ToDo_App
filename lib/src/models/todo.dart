class ToDo {
  String? sId;
  String? titulo;
  String? data;
  int? prioridade;
  List<String>? categorias;
  List<Etapas>? etapas;
  int? iV;
  bool? concluido;

  ToDo(
      {this.sId,
      this.titulo,
      this.data,
      this.prioridade,
      this.categorias,
      this.etapas,
      this.iV, this.concluido = false});

  ToDo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    titulo = json['titulo'];
    data = json['data'];
    prioridade = json['prioridade'];
    concluido = json['concluido'];
    categorias = json['categorias'].cast<String>();
    if (json['etapas'] != null) {
      etapas = <Etapas>[];
      json['etapas'].forEach((v) {
        etapas!.add(Etapas.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['titulo'] = titulo;
    data['data'] = this.data;
    data['prioridade'] = prioridade;
    data['concluido'] = concluido;
    data['categorias'] = categorias;
    if (etapas != null) {
      data['etapas'] = etapas!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class Etapas {
  int? id;
  String? nome;
  bool? concluido;
  String? sId;

  Etapas({this.id, this.nome, this.concluido = false, this.sId});

  Etapas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    concluido = json['concluido'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['concluido'] = concluido;
    data['_id'] = sId;
    return data;
  }
}
