import '../../../domain/core/interfaces/karyawan_repository.dart';
import '../../../domain/core/model/karyawan_model.dart';
import '../../../domain/core/model/karyawan_param.dart';
import '../daos/provider/remote/remote_provider.dart';

class KaryawanRepositoryImpl implements KaryawanRepository {
  KaryawanRepositoryImpl() {
    RemoteProvider.init();
  }

  @override
  Future<List<KaryawanModel>?> getKaryawan() async {
    try {
      final response = await RemoteProvider.client.get('karyawan');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((e) => KaryawanModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<KaryawanModel>?> createKaryawan(KaryawanParam karyawan) async {
    try {
      final response =
          await RemoteProvider.client.post('karyawan', data: karyawan.toMap());

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((e) => KaryawanModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<KaryawanModel>?> updateKaryawan(
      KaryawanParam karyawan, int id) async {
    try {
      final response = await RemoteProvider.client
          .put('karyawan/$id', data: karyawan.toMap());

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((e) => KaryawanModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int?> deleteKaryawan(int id) async {
    try {
      final response = await RemoteProvider.client.delete('karyawan/$id');

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
