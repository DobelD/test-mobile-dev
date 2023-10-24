class KaryawanParam {
  final String name;
  final String alamat;
  final String position;
  final String status;
  KaryawanParam({
    required this.name,
    required this.alamat,
    required this.position,
    required this.status,
  });

  Map<String, dynamic> toMap() =>
      {'nama': name, 'alamat': alamat, 'posisi': position, 'status': status};
}
