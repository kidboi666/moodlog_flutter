abstract interface class BackupRepository {
  Future<void> backup({required String userId});
  Future<void> restore({required String userId});
}
