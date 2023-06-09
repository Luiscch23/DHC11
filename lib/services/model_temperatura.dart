class Data {
  final String id;
  final String temperatura;
  final String fechaHora;

  Data({required this.id, required this.temperatura, required this.fechaHora});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      temperatura: json['temperatura'],
      fechaHora: json['fecha_hora'],
    );
  }
}
