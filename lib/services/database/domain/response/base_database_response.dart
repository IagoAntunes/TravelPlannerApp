abstract class BaseDatabaseResponse<T> {
  dynamic data;
  BaseDatabaseResponse({
    required this.data,
  });
}

class SuccessDatabaseResponse<T> extends BaseDatabaseResponse {
  SuccessDatabaseResponse({required super.data});
}

class ErrorDatabaseResponse<T> extends BaseDatabaseResponse {
  ErrorDatabaseResponse({required super.data});
}

abstract class TypesQueryDatabase {}

class GetTypeQueryDatabase extends TypesQueryDatabase {}
