class KaryawanModel {
  int? id;
  String? nama;
  String? alamat;
  String? posisi;
  String? status;
  String? createdAt;
  String? updatedAt;

  KaryawanModel(
      {this.id,
      this.nama,
      this.alamat,
      this.posisi,
      this.status,
      this.createdAt,
      this.updatedAt});

  KaryawanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    alamat = json['alamat'];
    posisi = json['posisi'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['alamat'] = alamat;
    data['posisi'] = posisi;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
