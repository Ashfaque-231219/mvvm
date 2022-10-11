// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  SiteSurveyReportsDao? _siteSurveyReportsDaoInstance;

  ReportTypeDao? _reportTypeDaoInstance;

  ReportDao? _reportDaoInstance;

  ProjectDetailDao? _projectDetailDaoInstance;

  ProjectCategoryDao? _projectCategoryDaoInstance;

  PunchListDao? _punchListDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `survey_reports` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `report_id` INTEGER, `length` TEXT, `width` TEXT, `onloading_location` TEXT, `offloading_location` TEXT, `layout_plan_image` TEXT, `description` TEXT, `image_360_degree` TEXT, `report_category_id` TEXT, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `report_type` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `report_name` TEXT, `report_id` INTEGER, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `report` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `report_name` TEXT, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `project_details` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `project_name` TEXT, `address` TEXT, `logo` TEXT, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `project_category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `color` TEXT, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `punch_list` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `before_image` TEXT, `reference_id` INTEGER, `after_image` TEXT, `before_description` TEXT, `after_description` TEXT, `expected_completion_date` TEXT, `actual_completion_date` TEXT, `status` TEXT, `created_at` TEXT, `updated_at` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SiteSurveyReportsDao get siteSurveyReportsDao {
    return _siteSurveyReportsDaoInstance ??=
        _$SiteSurveyReportsDao(database, changeListener);
  }

  @override
  ReportTypeDao get reportTypeDao {
    return _reportTypeDaoInstance ??= _$ReportTypeDao(database, changeListener);
  }

  @override
  ReportDao get reportDao {
    return _reportDaoInstance ??= _$ReportDao(database, changeListener);
  }

  @override
  ProjectDetailDao get projectDetailDao {
    return _projectDetailDaoInstance ??=
        _$ProjectDetailDao(database, changeListener);
  }

  @override
  ProjectCategoryDao get projectCategoryDao {
    return _projectCategoryDaoInstance ??=
        _$ProjectCategoryDao(database, changeListener);
  }

  @override
  PunchListDao get punchListDao {
    return _punchListDaoInstance ??= _$PunchListDao(database, changeListener);
  }
}

class _$SiteSurveyReportsDao extends SiteSurveyReportsDao {
  _$SiteSurveyReportsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _siteSurveyReportsInsertionAdapter = InsertionAdapter(
            database,
            'survey_reports',
            (SiteSurveyReports item) => <String, Object?>{
                  'id': item.id,
                  'report_id': item.reportId,
                  'length': item.length,
                  'width': item.width,
                  'onloading_location': item.onloadingLocation,
                  'offloading_location': item.offloadingLocation,
                  'layout_plan_image': item.layoutPlanImage,
                  'description': item.description,
                  'image_360_degree': item.image360Degree,
                  'report_category_id': item.reportCategoryId,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SiteSurveyReports> _siteSurveyReportsInsertionAdapter;

  @override
  Future<SiteSurveyReports?> updateLayoutPlanImage(
      int id,
      String layoutPlanImage,
      String description,
      String createdAt,
      String updatedAt) async {
    return _queryAdapter.query(
        'UPDATE survey_reports SET layout_plan_image=?2,description=?3,created_at=?4,updated_at=?5 WHERE id=?1',
        mapper: (Map<String, Object?> row) => SiteSurveyReports(id: row['id'] as int?, reportId: row['report_id'] as int?, length: row['length'] as String?, width: row['width'] as String?, onloadingLocation: row['onloading_location'] as String?, offloadingLocation: row['offloading_location'] as String?, layoutPlanImage: row['layout_plan_image'] as String?, description: row['description'] as String?, createdAt: row['created_at'] as String?, image360Degree: row['image_360_degree'] as String?, reportCategoryId: row['report_category_id'] as String?, updatedAt: row['updated_at'] as String?),
        arguments: [id, layoutPlanImage, description, createdAt, updatedAt]);
  }

  @override
  Future<SiteSurveyReports?> update360Image(
      int id,
      String image360Degree,
      String reportCategoryId,
      String description,
      String createdAt,
      String updatedAt) async {
    return _queryAdapter.query(
        'UPDATE survey_reports SET image_360_degree=?2,report_category_id=?3,description=?4,created_at=?5,updated_at=?6 WHERE id=?1',
        mapper: (Map<String, Object?> row) => SiteSurveyReports(id: row['id'] as int?, reportId: row['report_id'] as int?, length: row['length'] as String?, width: row['width'] as String?, onloadingLocation: row['onloading_location'] as String?, offloadingLocation: row['offloading_location'] as String?, layoutPlanImage: row['layout_plan_image'] as String?, description: row['description'] as String?, createdAt: row['created_at'] as String?, image360Degree: row['image_360_degree'] as String?, reportCategoryId: row['report_category_id'] as String?, updatedAt: row['updated_at'] as String?),
        arguments: [
          id,
          image360Degree,
          reportCategoryId,
          description,
          createdAt,
          updatedAt
        ]);
  }

  @override
  Future<SiteSurveyReports?> getReportById(int id) async {
    return _queryAdapter.query('SELECT * FROM survey_reports WHERE id= ?1',
        mapper: (Map<String, Object?> row) => SiteSurveyReports(
            id: row['id'] as int?,
            reportId: row['report_id'] as int?,
            length: row['length'] as String?,
            width: row['width'] as String?,
            onloadingLocation: row['onloading_location'] as String?,
            offloadingLocation: row['offloading_location'] as String?,
            layoutPlanImage: row['layout_plan_image'] as String?,
            description: row['description'] as String?,
            createdAt: row['created_at'] as String?,
            image360Degree: row['image_360_degree'] as String?,
            reportCategoryId: row['report_category_id'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<SiteSurveyReports?>> getAllSiteSurveyReport() async {
    return _queryAdapter.queryList('SELECT * FROM survey_reports',
        mapper: (Map<String, Object?> row) => SiteSurveyReports(
            id: row['id'] as int?,
            reportId: row['report_id'] as int?,
            length: row['length'] as String?,
            width: row['width'] as String?,
            onloadingLocation: row['onloading_location'] as String?,
            offloadingLocation: row['offloading_location'] as String?,
            layoutPlanImage: row['layout_plan_image'] as String?,
            description: row['description'] as String?,
            createdAt: row['created_at'] as String?,
            image360Degree: row['image_360_degree'] as String?,
            reportCategoryId: row['report_category_id'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<int> insertUser(SiteSurveyReports siteSurveyReports) {
    return _siteSurveyReportsInsertionAdapter.insertAndReturnId(
        siteSurveyReports, OnConflictStrategy.abort);
  }
}

class _$ReportTypeDao extends ReportTypeDao {
  _$ReportTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _getReportTypeInsertionAdapter = InsertionAdapter(
            database,
            'report_type',
            (GetReportType item) => <String, Object?>{
                  'id': item.id,
                  'report_name': item.reportName,
                  'report_id': item.reportId,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GetReportType> _getReportTypeInsertionAdapter;

  @override
  Future<List<GetReportType>> getAllReports() async {
    return _queryAdapter.queryList('SELECT * FROM report_type',
        mapper: (Map<String, Object?> row) => GetReportType(
            id: row['id'] as int?,
            reportId: row['report_id'] as int?,
            reportName: row['report_name'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<List<int?>?> getAllReportsId() async {
    await _queryAdapter.queryNoReturn('SELECT report_id FROM report_type');
  }

  @override
  Future<GetReportType?> getReportTypeById(int id) async {
    return _queryAdapter.query('SELECT * FROM report_type WHERE id= ?1',
        mapper: (Map<String, Object?> row) => GetReportType(
            id: row['id'] as int?,
            reportId: row['report_id'] as int?,
            reportName: row['report_name'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<GetReportType?> updateReportId(int id, int reportId) async {
    return _queryAdapter.query(
        'UPDATE report_type SET report_id=?2 WHERE id=?1',
        mapper: (Map<String, Object?> row) => GetReportType(
            id: row['id'] as int?,
            reportId: row['report_id'] as int?,
            reportName: row['report_name'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id, reportId]);
  }

  @override
  Future<int> insertReportType(GetReportType reportType) {
    return _getReportTypeInsertionAdapter.insertAndReturnId(
        reportType, OnConflictStrategy.abort);
  }
}

class _$ReportDao extends ReportDao {
  _$ReportDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _reportInsertionAdapter = InsertionAdapter(
            database,
            'report',
            (Report item) => <String, Object?>{
                  'id': item.id,
                  'report_name': item.reportName,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Report> _reportInsertionAdapter;

  @override
  Future<List<Report>> getAllReports() async {
    return _queryAdapter.queryList('SELECT * FROM report',
        mapper: (Map<String, Object?> row) => Report(
            id: row['id'] as int?,
            reportName: row['report_name'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<int> insertReport(Report report) {
    return _reportInsertionAdapter.insertAndReturnId(
        report, OnConflictStrategy.abort);
  }
}

class _$ProjectDetailDao extends ProjectDetailDao {
  _$ProjectDetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _projectDetailInsertionAdapter = InsertionAdapter(
            database,
            'project_details',
            (ProjectDetail item) => <String, Object?>{
                  'id': item.id,
                  'project_name': item.projectName,
                  'address': item.address,
                  'logo': item.logo,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProjectDetail> _projectDetailInsertionAdapter;

  @override
  Future<List<ProjectDetail>> getAllProject() async {
    return _queryAdapter.queryList('SELECT * FROM project_details',
        mapper: (Map<String, Object?> row) => ProjectDetail(
            id: row['id'] as int?,
            projectName: row['project_name'] as String?,
            address: row['address'] as String?,
            updatedAt: row['updated_at'] as String?,
            logo: row['logo'] as String?,
            createdAt: row['created_at'] as String?));
  }

  @override
  Future<int> insertProject(ProjectDetail projectDetail) {
    return _projectDetailInsertionAdapter.insertAndReturnId(
        projectDetail, OnConflictStrategy.abort);
  }
}

class _$ProjectCategoryDao extends ProjectCategoryDao {
  _$ProjectCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _projectCategoriesInsertionAdapter = InsertionAdapter(
            database,
            'project_category',
            (ProjectCategories item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'color': item.color,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProjectCategories> _projectCategoriesInsertionAdapter;

  @override
  Future<List<ProjectCategories>> getAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM project_category',
        mapper: (Map<String, Object?> row) => ProjectCategories(
            id: row['id'] as int?,
            name: row['name'] as String?,
            color: row['color'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<int> insertCategory(ProjectCategories projectCategory) {
    return _projectCategoriesInsertionAdapter.insertAndReturnId(
        projectCategory, OnConflictStrategy.abort);
  }
}

class _$PunchListDao extends PunchListDao {
  _$PunchListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _punchListInsertionAdapter = InsertionAdapter(
            database,
            'punch_list',
            (PunchList item) => <String, Object?>{
                  'id': item.id,
                  'before_image': item.beforeImage,
                  'reference_id': item.referenceId,
                  'after_image': item.afterImage,
                  'before_description': item.beforeDescription,
                  'after_description': item.afterDescription,
                  'expected_completion_date': item.expectedCompletionDate,
                  'actual_completion_date': item.actualCompletionDate,
                  'status': item.status,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PunchList> _punchListInsertionAdapter;

  @override
  Future<PunchList?> getPunchListById(int id) async {
    return _queryAdapter.query('SELECT * FROM punch_list WHERE id= ?1',
        mapper: (Map<String, Object?> row) => PunchList(
            id: row['id'] as int?,
            status: row['status'] as String?,
            referenceId: row['reference_id'] as int?,
            actualCompletionDate: row['actual_completion_date'] as String?,
            afterDescription: row['after_description'] as String?,
            afterImage: row['after_image'] as String?,
            beforeDescription: row['before_description'] as String?,
            beforeImage: row['before_image'] as String?,
            expectedCompletionDate: row['expected_completion_date'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<PunchList>> getAllIssues() async {
    return _queryAdapter.queryList('SELECT * FROM punch_list',
        mapper: (Map<String, Object?> row) => PunchList(
            id: row['id'] as int?,
            status: row['status'] as String?,
            referenceId: row['reference_id'] as int?,
            actualCompletionDate: row['actual_completion_date'] as String?,
            afterDescription: row['after_description'] as String?,
            afterImage: row['after_image'] as String?,
            beforeDescription: row['before_description'] as String?,
            beforeImage: row['before_image'] as String?,
            expectedCompletionDate: row['expected_completion_date'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<List<PunchList>> getAllStatus() async {
    return _queryAdapter.queryList('SELECT status FROM punch_list',
        mapper: (Map<String, Object?> row) => PunchList(
            id: row['id'] as int?,
            status: row['status'] as String?,
            referenceId: row['reference_id'] as int?,
            actualCompletionDate: row['actual_completion_date'] as String?,
            afterDescription: row['after_description'] as String?,
            afterImage: row['after_image'] as String?,
            beforeDescription: row['before_description'] as String?,
            beforeImage: row['before_image'] as String?,
            expectedCompletionDate: row['expected_completion_date'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<PunchList?> resolvePunchList(
      int id,
      String afterImage,
      String afterDescription,
      String actualCompletionDate,
      String createdAt,
      String updatedAt,
      String status) async {
    return _queryAdapter.query(
        'UPDATE punch_list SET after_image=?2,after_description=?3,actual_completion_date=?4,status=?7,created_at=?5,updated_at=?6 WHERE id=?1',
        mapper: (Map<String, Object?> row) => PunchList(
            id: row['id'] as int?,
            status: row['status'] as String?,
            referenceId: row['reference_id'] as int?,
            actualCompletionDate: row['actual_completion_date'] as String?,
            afterDescription: row['after_description'] as String?,
            afterImage: row['after_image'] as String?,
            beforeDescription: row['before_description'] as String?,
            beforeImage: row['before_image'] as String?,
            expectedCompletionDate: row['expected_completion_date'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [
          id,
          afterImage,
          afterDescription,
          actualCompletionDate,
          createdAt,
          updatedAt,
          status
        ]);
  }

  @override
  Future<int> insertPunchList(PunchList punchList) {
    return _punchListInsertionAdapter.insertAndReturnId(
        punchList, OnConflictStrategy.abort);
  }
}
