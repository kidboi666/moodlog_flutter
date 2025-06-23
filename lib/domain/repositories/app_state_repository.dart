abstract class AppStateRepository {
  Future<void> initializeFirstLaunchStatus();

  Future<void> updateExecutedDate();
}
