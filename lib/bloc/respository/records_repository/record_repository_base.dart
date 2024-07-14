import 'package:milk_analysis/bloc/modules/record_module.dart';
import 'package:milk_analysis/provider/record_provider.dart';
import 'package:milk_analysis/provider/user_provider.dart';

abstract interface class RecordRepositoryBase {

  Future<Record?> saveRecord({
    required String summary,
    required double pH,
    required String healthImplications,
    required UserProvider userProvider
  });

  Future<int> deleteRecord({
    required Record record,
    required int recordId,
    required UserProvider userProvider
  });

  Future<List<Record>> getAllRecords({
    required UserProvider userProvider
  });

}