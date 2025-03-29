abstract class NetworkSourceFileBlueprint<T> {
  /// Creates a new entity
  Future<void> create(T entity);

  /// Reads/Retrieves an entity by its identifier
  Future<T?> read(String id);

  /// Updates an existing entity
  Future<void> update(T entity);

  /// Deletes an entity by its identifier
  Future<void> delete(String id);
}
