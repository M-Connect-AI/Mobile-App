abstract interface class ChatTextSizeRepository {
  Future<int?> read();

  Future<void> save(int size);
}
