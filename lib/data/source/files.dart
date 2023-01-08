abstract class Files {
  Future<String?> read(String path);

  Future<void> write(String path, String content);

  Future<void> delete(String path);
}
