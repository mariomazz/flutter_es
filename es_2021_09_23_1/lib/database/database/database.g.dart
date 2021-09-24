// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EmployeeDao? _employeeDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Employee` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `firstName` TEXT NOT NULL, `lastName` TEXT NOT NULL, `email` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EmployeeDao get employeeDAO {
    return _employeeDAOInstance ??= _$EmployeeDao(database, changeListener);
  }
}

class _$EmployeeDao extends EmployeeDao {
  _$EmployeeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _employeeInsertionAdapter = InsertionAdapter(
            database,
            'Employee',
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'email': item.email
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Employee> _employeeInsertionAdapter;

  @override
  Future<List<Employee>> getAllEmployee() async {
    return _queryAdapter.queryList('SELECT * FROM Employee',
        mapper: (Map<String, Object?> row) => Employee(
            id: row['id'] as int,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            email: row['email'] as String));
  }

  @override
  Future<Employee?> getEmployeebyId(int id) async {
    return _queryAdapter.query('SELECT * FROM Employee WHERE id=?1',
        mapper: (Map<String, Object?> row) => Employee(
            id: row['id'] as int,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            email: row['email'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteEmployee() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Employee');
  }

  @override
  Future<void> deleteEmployeeById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Employee WHERE id=?1', arguments: [id]);
  }

  @override
  Future<void> insertAllEmployee(List<Employee> todo) async {
    await _employeeInsertionAdapter.insertList(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertEmployee(Employee employee) async {
    await _employeeInsertionAdapter.insert(employee, OnConflictStrategy.abort);
  }
}
