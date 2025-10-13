abstract interface class BackupRepository {
  Future<void> backup();
  Future<void> restore();
}
