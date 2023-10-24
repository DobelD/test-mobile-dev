import '../model/karyawan_model.dart';
import '../model/karyawan_param.dart';

abstract class KaryawanRepository {
  Future<List<KaryawanModel>?> getKaryawan();
  Future<List<KaryawanModel>?> createKaryawan(KaryawanParam karyawan);
  Future<List<KaryawanModel>?> updateKaryawan(KaryawanParam karyawan, int id);
  Future<int?> deleteKaryawan(int id);
}
