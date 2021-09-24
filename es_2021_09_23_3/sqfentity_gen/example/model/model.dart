import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

// STEP 1: define your tables as shown in the example Classes below.

// Define the 'tableCategory' constant as SqfEntityTable for the category table
const tableCategory = SqfEntityTable(
    tableName: 'category',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
    modelName:
        null, // SqfEntity will set it to TableName automatically when the modelName (class name) is null
    // declare fields
    fields: [
      SqfEntityField('name', DbType.text, isNotNull: true),
      SqfEntityField('isActive', DbType.bool, defaultValue: true),
    ],
    formListSubTitleField: '');

// Define the 'tableProduct' constant as SqfEntityTable for the product table
const tableProduct = SqfEntityTable(
    tableName: 'product',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField(
        'name',
        DbType.text,
        isNotNull: true,
      ),
      SqfEntityField('description', DbType.text),
      SqfEntityField('price', DbType.real, defaultValue: 0),
      SqfEntityField('isActive', DbType.bool, defaultValue: true),

      /// Relationship column for CategoryId of Product
      SqfEntityFieldRelationship(
          parentTable: tableCategory,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 1,
          formDropDownTextField:
              'name' // displayText of dropdownList for category. 'name' => a text field from the category table
          ),
      SqfEntityField('rownum', DbType.integer,
          sequencedBy:
              seqIdentity /*Example of linking a column to a sequence */),
      SqfEntityField('imageUrl', DbType.text),
      SqfEntityField('datetime', DbType.datetime,
          defaultValue: 'DateTime.now()',
          minValue: '2019-01-01',
          maxValue: 'DateTime.now().add(Duration(days: 30))'),
      SqfEntityField('date', DbType.date,
          minValue: '2015-01-01',
          maxValue: 'DateTime.now().add(Duration(days: 365))')
    ]);

// Define the 'Todo' constant as SqfEntityTable.
const tableTodo = SqfEntityTable(
    tableName: 'todos',
    primaryKeyName: 'id',
    useSoftDeleting:
        false, // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
    primaryKeyType: PrimaryKeyType.integer_unique,
    defaultJsonUrl:
        'https://jsonplaceholder.typicode.com/todos', // optional: to synchronize your table with json data from webUrl

    // declare fields
    fields: [
      SqfEntityField('userId', DbType.integer),
      SqfEntityField('title', DbType.text),
      SqfEntityField('completed', DbType.bool, defaultValue: false),
    ]);

// Define the 'identity' constant as SqfEntitySequence.
const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
  //maxValue:  10000, /* optional. default is max int (9.223.372.036.854.775.807) */
  //modelName: 'SQEidentity',
  /* optional. SqfEntity will set it to sequenceName automatically when the modelName is null*/
  //cycle : false,    /* optional. default is false; */
  //minValue = 0;     /* optional. default is 0 */
  //incrementBy = 1;  /* optional. default is 1 */
  // startWith = 0;   /* optional. default is 0 */
);

// STEP 2: Create your Database Model constant instanced from SqfEntityModel
// Note: SqfEntity provides support for the use of multiple databases.
// So you can create many Database Models and use them in the application.
@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel',
    databaseName: 'sampleORM_v2.1.0+3.db',
    password:
        null, // You can set a password if you want to use crypted database (For more information: https://github.com/sqlcipher/sqlcipher)
    // put defined tables into the tables list.
    databaseTables: [tableProduct, tableCategory, tableTodo],
    // You can define tables to generate add/edit view forms if you want to use Form Generator property
    formTables: [tableProduct, tableCategory, tableTodo],
    // put defined sequences into the sequences list.
    sequences: [seqIdentity],
    dbVersion: 2,
    bundledDatabasePath: null, //         'assets/sample.db'
    // This value is optional. When bundledDatabasePath is empty then
    // EntityBase creats a new database when initializing the database
    defaultColumns: [
      SqfEntityField('dateCreated', DbType.datetime,
          defaultValue: 'DateTime.now()'),
    ]);

/* STEP 3: That's All.. 
--> Go Terminal Window and run command below
    flutter pub run build_runner build --delete-conflicting-outputs
  Note: After running the command Please check lib/model/model.g.dart and lib/model/model.g.view.dart (If formTables parameter is defined in the model)
  Enjoy.. Huseyin TOKPINAR
*/

//  To use these SqfEntity classes do following:
//  - import model.dart into where to use
//  - start typing ex:Product.select()... (add a few filters with fluent methods)...(add orderBy/orderBydesc if you want)...
//  - and then just put end of filters / or end of only select()  toSingle() / or toList()
//  - you can select one or return List<yourObject> by your filters and orders
//  - also you can batch update or batch delete by using delete/update methods instead of tosingle/tolist methods
//    Enjoy.. Huseyin Tokpunar

// BEGIN TABLES
// Product TABLE
class TableProduct extends SqfEntityTableBase {
  TableProduct() {
    // declare properties of EntityTable
    tableName = 'product';
    primaryKeyName = 'id';
    primaryKeyType = PrimaryKeyType.integer_auto_incremental;
    useSoftDeleting = true;
    // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)

    // declare fields
    fields = [
      SqfEntityFieldBase('name', DbType.text,
          isUnique: false, isNotNull: true, isIndex: false),
      SqfEntityFieldBase('description', DbType.text,
          isUnique: false, isNotNull: false, isIndex: false),
      SqfEntityFieldBase('price', DbType.real,
          defaultValue: 0, isUnique: false, isNotNull: false, isIndex: false),
      SqfEntityFieldBase('isActive', DbType.bool,
          defaultValue: true,
          isUnique: false,
          isNotNull: false,
          isIndex: false),
      SqfEntityFieldRelationshipBase(
          TableCategory.getInstance, DeleteRule.CASCADE,
          relationType: RelationType.ONE_TO_MANY,
          fieldName: 'categoryId',
          defaultValue: 1,
          isUnique: false,
          isNotNull: false,
          isIndex: false),
      SqfEntityFieldBase('rownum', DbType.integer,
          isUnique: false, isNotNull: false, isIndex: false),
      SqfEntityFieldBase('imageUrl', DbType.text,
          isUnique: false, isNotNull: false, isIndex: false),
      SqfEntityFieldBase('datetime', DbType.datetime,
          defaultValue: DateTime.now(),
          isUnique: false,
          isNotNull: false,
          isIndex: false,
          minValue: DateTime.parse('2019-01-01'),
          maxValue: DateTime.now().add(Duration(days: 30))),
      SqfEntityFieldBase('date', DbType.date,
          isUnique: false,
          isNotNull: false,
          isIndex: false,
          minValue: DateTime.parse('2015-01-01'),
          maxValue: DateTime.now().add(Duration(days: 365))),
      SqfEntityFieldBase('dateCreated', DbType.datetime,
          defaultValue: DateTime.now(),
          isUnique: false,
          isNotNull: false,
          isIndex: false,
          minValue: DateTime.parse('1900-01-01')),
    ];
    super.init();
  }
  static SqfEntityTableBase? _instance;
  static SqfEntityTableBase get getInstance {
    return _instance = _instance ?? TableProduct();
  }
}

// Category TABLE
class TableCategory extends SqfEntityTableBase {
  TableCategory() {
    // declare properties of EntityTable
    tableName = 'category';
    primaryKeyName = 'id';
    primaryKeyType = PrimaryKeyType.integer_auto_incremental;
    useSoftDeleting = false;
    // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)

    // declare fields
    fields = [
      SqfEntityFieldBase('name', DbType.text,
          isUnique: false, isNotNull: true, isIndex: false),
      SqfEntityFieldBase('isActive', DbType.bool,
          defaultValue: true,
          isUnique: false,
          isNotNull: false,
          isIndex: false),
    ];
    super.init();
  }
  static SqfEntityTableBase? _instance;
  static SqfEntityTableBase get getInstance {
    return _instance = _instance ?? TableCategory();
  }
}

// Todo TABLE
class TableTodo extends SqfEntityTableBase {
  TableTodo() {
    // declare properties of EntityTable
    tableName = 'todos';
    primaryKeyName = 'id';
    primaryKeyType = PrimaryKeyType.integer_unique;
    useSoftDeleting = false;
    // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)

    // declare fields
    fields = [
      SqfEntityFieldBase('userId', DbType.integer,
          isUnique: false, isNotNull: false, isIndex: false),
      SqfEntityFieldBase('title', DbType.text,
          isUnique: false, isNotNull: false, isIndex: false),
      SqfEntityFieldBase('completed', DbType.bool,
          defaultValue: false,
          isUnique: false,
          isNotNull: false,
          isIndex: false),
      SqfEntityFieldBase('dateCreated', DbType.datetime,
          defaultValue: DateTime.now(),
          isUnique: false,
          isNotNull: false,
          isIndex: false,
          minValue: DateTime.parse('1900-01-01')),
    ];
    super.init();
  }
  static SqfEntityTableBase? _instance;
  static SqfEntityTableBase get getInstance {
    return _instance = _instance ?? TableTodo();
  }
}
// END TABLES

// BEGIN SEQUENCES
// identity SEQUENCE
class SequenceIdentitySequence extends SqfEntitySequenceBase {
  SequenceIdentitySequence() {
    sequenceName = 'identity';
    maxValue =
        9007199254740991; /* optional. default is max int (9.223.372.036.854.775.807) */
    cycle = false; /* optional. default is false; */
    minValue = 0; /* optional. default is 0 */
    incrementBy = 1; /* optional. default is 1 */
    startWith = 0; /* optional. default is 0 */
    super.init();
  }
  static SequenceIdentitySequence? _instance;
  static SequenceIdentitySequence get getInstance {
    return _instance = _instance ?? SequenceIdentitySequence();
  }
}
// END SEQUENCES

// BEGIN DATABASE MODEL
class MyDbModel extends SqfEntityModelProvider {
  MyDbModel() {
    databaseName = myDbModel.databaseName;
    password = myDbModel.password;
    dbVersion = myDbModel.dbVersion;
    preSaveAction = myDbModel.preSaveAction;
    logFunction = myDbModel.logFunction;
    databaseTables = [
      TableProduct.getInstance,
      TableCategory.getInstance,
      TableTodo.getInstance,
    ];

    sequences = [
      SequenceIdentitySequence.getInstance,
    ];

    bundledDatabasePath = myDbModel
        .bundledDatabasePath; //'assets/sample.db'; // This value is optional. When bundledDatabasePath is empty then EntityBase creats a new database when initializing the database
  }
}
// END DATABASE MODEL

// BEGIN ENTITIES
// region Product
class Product extends TableBase {
  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.isActive,
      this.categoryId,
      this.rownum,
      this.imageUrl,
      this.datetime,
      this.date,
      this.dateCreated,
      this.isDeleted}) {
    _setDefaultValues();
  }
  Product.withFields(
      this.name,
      this.description,
      this.price,
      this.isActive,
      this.categoryId,
      this.rownum,
      this.imageUrl,
      this.datetime,
      this.date,
      this.dateCreated,
      this.isDeleted) {
    _setDefaultValues();
  }
  Product.withId(
      this.id,
      this.name,
      this.description,
      this.price,
      this.isActive,
      this.categoryId,
      this.rownum,
      this.imageUrl,
      this.datetime,
      this.date,
      this.dateCreated,
      this.isDeleted) {
    _setDefaultValues();
  }
  // fromMap v2.0
  Product.fromMap(Map<String, dynamic> o, {bool setDefaultValues = true}) {
    if (setDefaultValues) {
      _setDefaultValues();
    }
    id = int.tryParse(o['id'].toString());
    if (o['name'] != null) {
      name = o['name'].toString();
    }
    if (o['description'] != null) {
      description = o['description'].toString();
    }
    if (o['price'] != null) {
      price = double.tryParse(o['price'].toString());
    }
    if (o['isActive'] != null) {
      isActive =
          o['isActive'].toString() == '1' || o['isActive'].toString() == 'true';
    }
    categoryId = int.tryParse(o['categoryId'].toString());

    if (o['rownum'] != null) {
      rownum = int.tryParse(o['rownum'].toString());
    }
    if (o['imageUrl'] != null) {
      imageUrl = o['imageUrl'].toString();
    }
    if (o['datetime'] != null) {
      datetime = int.tryParse(o['datetime'].toString()) != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(o['datetime'].toString())!)
          : DateTime.tryParse(o['datetime'].toString());
    }
    if (o['date'] != null) {
      date = int.tryParse(o['date'].toString()) != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(o['date'].toString())!)
          : DateTime.tryParse(o['date'].toString());
    }
    if (o['dateCreated'] != null) {
      dateCreated = int.tryParse(o['dateCreated'].toString()) != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(o['dateCreated'].toString())!)
          : DateTime.tryParse(o['dateCreated'].toString());
    }
    isDeleted = o['isDeleted'] != null
        ? o['isDeleted'] == 1 || o['isDeleted'] == true
        : null;

    // RELATIONSHIPS FromMAP
    plCategory = o['category'] != null
        ? Category.fromMap(o['category'] as Map<String, dynamic>)
        : null;
    // END RELATIONSHIPS FromMAP
  }
  // FIELDS (Product)
  int? id;
  String? name;
  String? description;
  double? price;
  bool? isActive;
  int? categoryId;
  int? rownum;
  String? imageUrl;
  DateTime? datetime;
  DateTime? date;
  DateTime? dateCreated;
  bool? isDeleted;

  BoolResult? saveResult;
  // end FIELDS (Product)

// RELATIONSHIPS (Product)
  /// to load parent of items to this field, use preload parameter ex: toList(preload:true) or toSingle(preload:true) or getById(preload:true)
  /// You can also specify this object into certain preload fields!. Ex: toList(preload:true, preloadFields:['plCategory', 'plField2'..]) or so on..
  Category? plCategory;

  /// get Category By CategoryId
  Future<Category?> getCategory(
      {bool loadParents = false, List<String>? loadedFields}) async {
    final _obj = await Category().getById(categoryId,
        loadParents: loadParents, loadedFields: loadedFields);
    return _obj;
  }
  // END RELATIONSHIPS (Product)

  static const bool _softDeleteActivated = true;
  ProductManager? __mnProduct;

  ProductManager get _mnProduct {
    return __mnProduct = __mnProduct ?? ProductManager();
  }

  // METHODS
  Map<String, dynamic> toMap(
      {bool forQuery = false, bool forJson = false, bool forView = false}) {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    if (name != null) {
      map['name'] = name;
    }

    if (description != null) {
      map['description'] = description;
    }

    if (price != null) {
      map['price'] = price;
    }

    if (isActive != null) {
      map['isActive'] = forQuery ? (isActive! ? 1 : 0) : isActive;
    }

    if (categoryId != null) {
      map['categoryId'] = forView
          ? plCategory == null
              ? categoryId
              : plCategory!.name
          : categoryId;
    }

    if (rownum != null) {
      map['rownum'] = rownum;
    }

    if (imageUrl != null) {
      map['imageUrl'] = imageUrl;
    }

    if (datetime != null) {
      map['datetime'] = forJson
          ? datetime!.toString()
          : forQuery
              ? datetime!.millisecondsSinceEpoch
              : datetime;
    }

    if (date != null) {
      map['date'] = forJson
          ? '$date!.year-$date!.month-$date!.day'
          : forQuery
              ? DateTime(date!.year, date!.month, date!.day)
                  .millisecondsSinceEpoch
              : date;
    }

    if (dateCreated != null) {
      map['dateCreated'] = forJson
          ? dateCreated!.toString()
          : forQuery
              ? dateCreated!.millisecondsSinceEpoch
              : dateCreated;
    }

    if (isDeleted != null) {
      map['isDeleted'] = forQuery ? (isDeleted! ? 1 : 0) : isDeleted;
    }

    return map;
  }

  Future<Map<String, dynamic>> toMapWithChildren(
      [bool forQuery = false,
      bool forJson = false,
      bool forView = false]) async {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    if (name != null) {
      map['name'] = name;
    }

    if (description != null) {
      map['description'] = description;
    }

    if (price != null) {
      map['price'] = price;
    }

    if (isActive != null) {
      map['isActive'] = forQuery ? (isActive! ? 1 : 0) : isActive;
    }

    if (categoryId != null) {
      map['categoryId'] = forView
          ? plCategory == null
              ? categoryId
              : plCategory!.name
          : categoryId;
    }

    if (rownum != null) {
      map['rownum'] = rownum;
    }

    if (imageUrl != null) {
      map['imageUrl'] = imageUrl;
    }

    if (datetime != null) {
      map['datetime'] = forJson
          ? datetime!.toString()
          : forQuery
              ? datetime!.millisecondsSinceEpoch
              : datetime;
    }

    if (date != null) {
      map['date'] = forJson
          ? '$date!.year-$date!.month-$date!.day'
          : forQuery
              ? DateTime(date!.year, date!.month, date!.day)
                  .millisecondsSinceEpoch
              : date;
    }

    if (dateCreated != null) {
      map['dateCreated'] = forJson
          ? dateCreated!.toString()
          : forQuery
              ? dateCreated!.millisecondsSinceEpoch
              : dateCreated;
    }

    if (isDeleted != null) {
      map['isDeleted'] = forQuery ? (isDeleted! ? 1 : 0) : isDeleted;
    }

    return map;
  }

  /// This method returns Json String [Product]
  String toJson() {
    return json.encode(toMap(forJson: true));
  }

  /// This method returns Json String [Product]
  Future<String> toJsonWithChilds() async {
    return json.encode(await toMapWithChildren(false, true));
  }

  List<dynamic> toArgs() {
    return [
      name,
      description,
      price,
      isActive,
      categoryId,
      rownum,
      imageUrl,
      datetime != null ? datetime!.millisecondsSinceEpoch : null,
      date != null ? date!.millisecondsSinceEpoch : null,
      dateCreated != null ? dateCreated!.millisecondsSinceEpoch : null,
      isDeleted
    ];
  }

  List<dynamic> toArgsWithIds() {
    return [
      id,
      name,
      description,
      price,
      isActive,
      categoryId,
      rownum,
      imageUrl,
      datetime != null ? datetime!.millisecondsSinceEpoch : null,
      date != null ? date!.millisecondsSinceEpoch : null,
      dateCreated != null ? dateCreated!.millisecondsSinceEpoch : null,
      isDeleted
    ];
  }

  static Future<List<Product>?> fromWebUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      return await fromJson(response.body);
    } catch (e) {
      print(
          'SQFENTITY ERROR Product.fromWebUrl: ErrorMessage: ${e.toString()}');
      return null;
    }
  }

  Future<http.Response> postUrl(Uri uri, {Map<String, String>? headers}) {
    return http.post(uri, headers: headers, body: toJson());
  }

  static Future<List<Product>> fromJson(String jsonBody) async {
    final Iterable list = await json.decode(jsonBody) as Iterable;
    var objList = <Product>[];
    try {
      objList = list
          .map((product) => Product.fromMap(product as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('SQFENTITY ERROR Product.fromJson: ErrorMessage: ${e.toString()}');
    }
    return objList;
  }

  static Future<List<Product>> fromMapList(List<dynamic> data,
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields,
      bool setDefaultValues = true}) async {
    final List<Product> objList = <Product>[];
    loadedFields = loadedFields ?? [];
    for (final map in data) {
      final obj = Product.fromMap(map as Map<String, dynamic>,
          setDefaultValues: setDefaultValues);
      // final List<String> _loadedFields = List<String>.from(loadedFields);

      // RELATIONSHIPS PRELOAD
      if (preload || loadParents) {
        loadedFields = loadedFields ?? [];
        if (/*!_loadedfields!.contains('category.plCategory') && */ (preloadFields ==
                null ||
            loadParents ||
            preloadFields.contains('plCategory'))) {
          /*_loadedfields!.add('category.plCategory');*/ obj.plCategory = obj
                  .plCategory ??
              await obj.getCategory(
                  loadParents: loadParents /*, loadedFields: _loadedFields*/);
        }
      } // END RELATIONSHIPS PRELOAD

      objList.add(obj);
    }
    return objList;
  }

  /// returns Product by ID if exist, otherwise returns null
  ///
  /// Primary Keys: int? id
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: getById(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: getById(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>returns Product if exist, otherwise returns null
  Future<Product?> getById(int? id,
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    if (id == null) {
      return null;
    }
    Product? obj;
    final data = await _mnProduct.getById([id]);
    if (data.length != 0) {
      obj = Product.fromMap(data[0] as Map<String, dynamic>);
      // final List<String> _loadedFields = loadedFields ?? [];

      // RELATIONSHIPS PRELOAD
      if (preload || loadParents) {
        loadedFields = loadedFields ?? [];
        if (/*!_loadedfields!.contains('category.plCategory') && */ (preloadFields ==
                null ||
            loadParents ||
            preloadFields.contains('plCategory'))) {
          /*_loadedfields!.add('category.plCategory');*/ obj.plCategory = obj
                  .plCategory ??
              await obj.getCategory(
                  loadParents: loadParents /*, loadedFields: _loadedFields*/);
        }
      } // END RELATIONSHIPS PRELOAD

    } else {
      obj = null;
    }
    return obj;
  }

  /// Saves the (Product) object. If the id field is null, saves as a new record and returns new id, if id is not null then updates record
  /// ignoreBatch = true as a default. Set ignoreBatch to false if you run more than one save() operation those are between batchStart and batchCommit
  /// <returns>Returns id
  Future<int?> save({bool ignoreBatch = true}) async {
    if (id == null || id == 0) {
      rownum = await IdentitySequence().nextVal();

      id = await _mnProduct.insert(this, ignoreBatch);
    } else {
      // id= await _upsert(); // removed in sqfentity_gen 1.3.0+6
      await _mnProduct.update(this);
    }

    return id;
  }

  /// Saves the (Product) object. If the id field is null, saves as a new record and returns new id, if id is not null then updates record
  ///
  /// ignoreBatch = true as a default. Set ignoreBatch to false if you run more than one save() operation those are between batchStart and batchCommit
  ///
  /// <returns>Returns id
  Future<int?> saveOrThrow({bool ignoreBatch = true}) async {
    if (id == null || id == 0) {
      rownum = await IdentitySequence().nextVal();

      id = await _mnProduct.insertOrThrow(this, ignoreBatch);

      isInsert = true;
    } else {
      // id= await _upsert(); // removed in sqfentity_gen 1.3.0+6
      await _mnProduct.updateOrThrow(this);
    }

    return id;
  }

  /// saveAs Product. Returns a new Primary Key value of Product

  /// <returns>Returns a new Primary Key value of Product
  Future<int?> saveAs() async {
    id = null;

    return save();
  }

  void rollbackId() {
    if (isInsert == true) {
      id = null;
    }
  }

  /// saveAll method saves the sent List<Product> as a bulk in one transaction
  ///
  /// Returns a <List<BoolResult>>
  static Future<List<dynamic>> saveAll(List<Product> products) async {
    // final results = _mnProduct.saveAll('INSERT OR REPLACE INTO product (id, name, description, price, isActive, categoryId, rownum, imageUrl, datetime, date, dateCreated,isDeleted)  VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',products);
    // return results; removed in sqfentity_gen 1.3.0+6
    await MyDbModel().batchStart();
    for (final obj in products) {
      await obj.save(ignoreBatch: false);
    }
    //    return MyDbModel().batchCommit();
    final result = await MyDbModel().batchCommit();
    for (int i = 0; i < products.length; i++) {
      if (products[i].id == null) {
        products[i].id = result![i] as int;
      }
    }

    return result!;
  }

  /// Updates if the record exists, otherwise adds a new row

  /// <returns>Returns id

  Future<int?> upsert() async {
    try {
      final result = await _mnProduct.rawInsert(
          'INSERT OR REPLACE INTO product (id, name, description, price, isActive, categoryId, rownum, imageUrl, datetime, date, dateCreated,isDeleted)  VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
          [
            id,
            name,
            description,
            price,
            isActive,
            categoryId,
            rownum,
            imageUrl,
            datetime != null ? datetime!.millisecondsSinceEpoch : null,
            date != null ? date!.millisecondsSinceEpoch : null,
            dateCreated != null ? dateCreated!.millisecondsSinceEpoch : null,
            isDeleted
          ]);
      if (result! > 0) {
        saveResult = BoolResult(
            success: true,
            successMessage: 'Product id=$id updated successfully');
      } else {
        saveResult = BoolResult(
            success: false, errorMessage: 'Product id=$id did not update');
      }
      return id;
    } catch (e) {
      saveResult = BoolResult(
          success: false,
          errorMessage: 'Product Save failed. Error: ${e.toString()}');
      return null;
    }
  }

  /// inserts or replaces the sent List<<Product>> as a bulk in one transaction.
  ///
  /// upsertAll() method is faster then saveAll() method. upsertAll() should be used when you are sure that the primary key is greater than zero
  ///
  /// Returns a BoolCommitResult
  Future<BoolCommitResult> upsertAll(List<Product> products) async {
    final results = await _mnProduct.rawInsertAll(
        'INSERT OR REPLACE INTO product (id, name, description, price, isActive, categoryId, rownum, imageUrl, datetime, date, dateCreated,isDeleted)  VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
        products);
    return results;
  }

  /// Deletes Product

  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted

  Future<BoolResult> delete([bool hardDelete = false]) async {
    print('SQFENTITIY: delete Product invoked (id=$id)');
    if (!_softDeleteActivated || hardDelete || isDeleted!) {
      return _mnProduct
          .delete(QueryParams(whereString: 'id=?', whereArguments: [id]));
    } else {
      return _mnProduct.updateBatch(
          QueryParams(whereString: 'id=?', whereArguments: [id]),
          {'isDeleted': 1});
    }
  }

  /// Recover Product>

  /// <returns>BoolResult res.success=Recovered, not res.success=Can not recovered
  Future<BoolResult> recover([bool recoverChilds = true]) async {
    print('SQFENTITIY: recover Product invoked (id=$id)');
    {
      return _mnProduct.updateBatch(
          QueryParams(whereString: 'id=?', whereArguments: [id]),
          {'isDeleted': 0});
    }
  }

  ProductFilterBuilder select(
      {List<String>? columnsToSelect, bool? getIsDeleted}) {
    return ProductFilterBuilder(this)
      .._getIsDeleted = getIsDeleted == true
      ..qparams.selectColumns = columnsToSelect;
  }

  ProductFilterBuilder distinct(
      {List<String>? columnsToSelect, bool? getIsDeleted}) {
    return ProductFilterBuilder(this)
      .._getIsDeleted = getIsDeleted == true
      ..qparams.selectColumns = columnsToSelect
      ..qparams.distinct = true;
  }

  void _setDefaultValues() {
    price = price ?? 0;
    isActive = isActive ?? true;
    categoryId = categoryId ?? 1;
    datetime = datetime ?? DateTime.now();
    dateCreated = dateCreated ?? DateTime.now();
    isDeleted = isDeleted ?? false;
  }
  // END METHODS
  // BEGIN CUSTOM CODE
  /*
      you can define customCode property of your SqfEntityTable constant. For example:
      const tablePerson = SqfEntityTable(
      tableName: 'person',
      primaryKeyName: 'id',
      primaryKeyType: PrimaryKeyType.integer_auto_incremental,
      fields: [
        SqfEntityField('firstName', DbType.text),
        SqfEntityField('lastName', DbType.text),
      ],
      customCode: '''
       String fullName()
       { 
         return '$firstName $lastName';
       }
      ''');
     */
  // END CUSTOM CODE
}
// endregion product

// region ProductField
class ProductField extends SearchCriteria {
  ProductField(this.productFB);
  // { param = DbParameter(); }
  DbParameter param = DbParameter();
  String _waitingNot = '';
  ProductFilterBuilder productFB;

  ProductField get not {
    _waitingNot = ' NOT ';
    return this;
  }

  ProductFilterBuilder equals(dynamic pValue) {
    param.expression = '=';
    productFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, productFB.parameters, param, SqlSyntax.EQuals,
            productFB._addedBlocks)
        : setCriteria(pValue, productFB.parameters, param, SqlSyntax.NotEQuals,
            productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder equalsOrNull(dynamic pValue) {
    param.expression = '=';
    productFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.EQualsOrNull, productFB._addedBlocks)
        : setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.NotEQualsOrNull, productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder isNull() {
    productFB._addedBlocks = setCriteria(
        0,
        productFB.parameters,
        param,
        SqlSyntax.IsNULL.replaceAll(SqlSyntax.notKeyword, _waitingNot),
        productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder contains(dynamic pValue) {
    if (pValue != null) {
      productFB._addedBlocks = setCriteria(
          '%${pValue.toString()}%',
          productFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          productFB._addedBlocks);
      _waitingNot = '';
      productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
          productFB._addedBlocks.retVal;
    }
    return productFB;
  }

  ProductFilterBuilder startsWith(dynamic pValue) {
    if (pValue != null) {
      productFB._addedBlocks = setCriteria(
          '${pValue.toString()}%',
          productFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          productFB._addedBlocks);
      _waitingNot = '';
      productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
          productFB._addedBlocks.retVal;
      productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
          productFB._addedBlocks.retVal;
    }
    return productFB;
  }

  ProductFilterBuilder endsWith(dynamic pValue) {
    if (pValue != null) {
      productFB._addedBlocks = setCriteria(
          '%${pValue.toString()}',
          productFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          productFB._addedBlocks);
      _waitingNot = '';
      productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
          productFB._addedBlocks.retVal;
    }
    return productFB;
  }

  ProductFilterBuilder between(dynamic pFirst, dynamic pLast) {
    if (pFirst != null && pLast != null) {
      productFB._addedBlocks = setCriteria(
          pFirst,
          productFB.parameters,
          param,
          SqlSyntax.Between.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          productFB._addedBlocks,
          pLast);
    } else if (pFirst != null) {
      if (_waitingNot != '') {
        productFB._addedBlocks = setCriteria(pFirst, productFB.parameters,
            param, SqlSyntax.LessThan, productFB._addedBlocks);
      } else {
        productFB._addedBlocks = setCriteria(pFirst, productFB.parameters,
            param, SqlSyntax.GreaterThanOrEquals, productFB._addedBlocks);
      }
    } else if (pLast != null) {
      if (_waitingNot != '') {
        productFB._addedBlocks = setCriteria(pLast, productFB.parameters, param,
            SqlSyntax.GreaterThan, productFB._addedBlocks);
      } else {
        productFB._addedBlocks = setCriteria(pLast, productFB.parameters, param,
            SqlSyntax.LessThanOrEquals, productFB._addedBlocks);
      }
    }
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder greaterThan(dynamic pValue) {
    param.expression = '>';
    productFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.GreaterThan, productFB._addedBlocks)
        : setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.LessThanOrEquals, productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder lessThan(dynamic pValue) {
    param.expression = '<';
    productFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, productFB.parameters, param, SqlSyntax.LessThan,
            productFB._addedBlocks)
        : setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.GreaterThanOrEquals, productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder greaterThanOrEquals(dynamic pValue) {
    param.expression = '>=';
    productFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.GreaterThanOrEquals, productFB._addedBlocks)
        : setCriteria(pValue, productFB.parameters, param, SqlSyntax.LessThan,
            productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder lessThanOrEquals(dynamic pValue) {
    param.expression = '<=';
    productFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.LessThanOrEquals, productFB._addedBlocks)
        : setCriteria(pValue, productFB.parameters, param,
            SqlSyntax.GreaterThan, productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }

  ProductFilterBuilder inValues(dynamic pValue) {
    productFB._addedBlocks = setCriteria(
        pValue,
        productFB.parameters,
        param,
        SqlSyntax.IN.replaceAll(SqlSyntax.notKeyword, _waitingNot),
        productFB._addedBlocks);
    _waitingNot = '';
    productFB._addedBlocks.needEndBlock![productFB._blockIndex] =
        productFB._addedBlocks.retVal;
    return productFB;
  }
}
// endregion ProductField

// region ProductFilterBuilder
class ProductFilterBuilder extends SearchCriteria {
  ProductFilterBuilder(Product obj) {
    whereString = '';
    groupByList = <String>[];
    _addedBlocks.needEndBlock!.add(false);
    _addedBlocks.waitingStartBlock!.add(false);
    _obj = obj;
  }
  AddedBlocks _addedBlocks = AddedBlocks(<bool>[], <bool>[]);
  int _blockIndex = 0;
  List<DbParameter> parameters = <DbParameter>[];
  List<String> orderByList = <String>[];
  Product? _obj;
  QueryParams qparams = QueryParams();
  int _pagesize = 0;
  int _page = 0;

  /// put the sql keyword 'AND'
  ProductFilterBuilder get and {
    if (parameters.isNotEmpty) {
      parameters[parameters.length - 1].wOperator = ' AND ';
    }
    return this;
  }

  /// put the sql keyword 'OR'
  ProductFilterBuilder get or {
    if (parameters.isNotEmpty) {
      parameters[parameters.length - 1].wOperator = ' OR ';
    }
    return this;
  }

  /// open parentheses
  ProductFilterBuilder get startBlock {
    _addedBlocks.waitingStartBlock!.add(true);
    _addedBlocks.needEndBlock!.add(false);
    _blockIndex++;
    if (_blockIndex > 1) {
      _addedBlocks.needEndBlock![_blockIndex - 1] = true;
    }
    return this;
  }

  /// String whereCriteria, write raw query without 'where' keyword. Like this: 'field1 like 'test%' and field2 = 3'
  ProductFilterBuilder where(String? whereCriteria, {dynamic parameterValue}) {
    if (whereCriteria != null && whereCriteria != '') {
      final DbParameter param = DbParameter(
          columnName: parameterValue == null ? null : '',
          hasParameter: parameterValue != null);
      _addedBlocks = setCriteria(parameterValue ?? 0, parameters, param,
          '($whereCriteria)', _addedBlocks);
      _addedBlocks.needEndBlock![_blockIndex] = _addedBlocks.retVal;
    }
    return this;
  }

  /// page = page number,
  ///
  /// pagesize = row(s) per page
  ProductFilterBuilder page(int page, int pagesize) {
    if (page > 0) {
      _page = page;
    }
    if (pagesize > 0) {
      _pagesize = pagesize;
    }
    return this;
  }

  /// int count = LIMIT
  ProductFilterBuilder top(int count) {
    if (count > 0) {
      _pagesize = count;
    }
    return this;
  }

  /// close parentheses
  ProductFilterBuilder get endBlock {
    if (_addedBlocks.needEndBlock![_blockIndex]) {
      parameters[parameters.length - 1].whereString += ' ) ';
    }
    _addedBlocks.needEndBlock!.removeAt(_blockIndex);
    _addedBlocks.waitingStartBlock!.removeAt(_blockIndex);
    _blockIndex--;
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='name, date'
  ///
  /// Example 2: argFields = ['name', 'date']
  ProductFilterBuilder orderBy(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        orderByList.add(argFields);
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            orderByList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='field1, field2'
  ///
  /// Example 2: argFields = ['field1', 'field2']
  ProductFilterBuilder orderByDesc(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        orderByList.add('$argFields desc ');
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            orderByList.add(' $s desc ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='field1, field2'
  ///
  /// Example 2: argFields = ['field1', 'field2']
  ProductFilterBuilder groupBy(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        groupByList.add(' $argFields ');
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            groupByList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='name, date'
  ///
  /// Example 2: argFields = ['name', 'date']
  ProductFilterBuilder having(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        havingList.add(argFields);
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            havingList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  ProductField setField(ProductField? field, String colName, DbType dbtype) {
    return ProductField(this)
      ..param = DbParameter(
          dbType: dbtype,
          columnName: colName,
          wStartBlock: _addedBlocks.waitingStartBlock![_blockIndex]);
  }

  ProductField? _id;
  ProductField get id {
    return _id = setField(_id, 'id', DbType.integer);
  }

  ProductField? _name;
  ProductField get name {
    return _name = setField(_name, 'name', DbType.text);
  }

  ProductField? _description;
  ProductField get description {
    return _description = setField(_description, 'description', DbType.text);
  }

  ProductField? _price;
  ProductField get price {
    return _price = setField(_price, 'price', DbType.real);
  }

  ProductField? _isActive;
  ProductField get isActive {
    return _isActive = setField(_isActive, 'isActive', DbType.bool);
  }

  ProductField? _categoryId;
  ProductField get categoryId {
    return _categoryId = setField(_categoryId, 'categoryId', DbType.integer);
  }

  ProductField? _rownum;
  ProductField get rownum {
    return _rownum = setField(_rownum, 'rownum', DbType.integer);
  }

  ProductField? _imageUrl;
  ProductField get imageUrl {
    return _imageUrl = setField(_imageUrl, 'imageUrl', DbType.text);
  }

  ProductField? _datetime;
  ProductField get datetime {
    return _datetime = setField(_datetime, 'datetime', DbType.datetime);
  }

  ProductField? _date;
  ProductField get date {
    return _date = setField(_date, 'date', DbType.date);
  }

  ProductField? _dateCreated;
  ProductField get dateCreated {
    return _dateCreated =
        setField(_dateCreated, 'dateCreated', DbType.datetime);
  }

  ProductField? _isDeleted;
  ProductField get isDeleted {
    return _isDeleted = setField(_isDeleted, 'isDeleted', DbType.bool);
  }

  bool _getIsDeleted = false;

  void _buildParameters() {
    if (_page > 0 && _pagesize > 0) {
      qparams
        ..limit = _pagesize
        ..offset = (_page - 1) * _pagesize;
    } else {
      qparams
        ..limit = _pagesize
        ..offset = _page;
    }
    for (DbParameter param in parameters) {
      if (param.columnName != null) {
        if (param.value is List && !param.hasParameter) {
          param.value = param.dbType == DbType.text || param.value[0] is String
              ? '\'${param.value.join('\',\'')}\''
              : param.value.join(',');
          whereString += param.whereString
              .replaceAll('{field}', param.columnName!)
              .replaceAll('?', param.value.toString());
          param.value = null;
        } else {
          if (param.value is Map<String, dynamic> &&
              param.value['sql'] != null) {
            param
              ..whereString = param.whereString
                  .replaceAll('?', param.value['sql'].toString())
              ..dbType = DbType.integer
              ..value = param.value['args'];
          }
          whereString +=
              param.whereString.replaceAll('{field}', param.columnName!);
        }
        if (!param.whereString.contains('?')) {
        } else {
          switch (param.dbType) {
            case DbType.bool:
              param.value = param.value == null
                  ? null
                  : param.value == true
                      ? 1
                      : 0;
              param.value2 = param.value2 == null
                  ? null
                  : param.value2 == true
                      ? 1
                      : 0;
              break;
            case DbType.date:
            case DbType.datetime:
            case DbType.datetimeUtc:
              param.value = param.value == null
                  ? null
                  : (param.value as DateTime).millisecondsSinceEpoch;
              param.value2 = param.value2 == null
                  ? null
                  : (param.value2 as DateTime).millisecondsSinceEpoch;
              break;
            default:
          }
          if (param.value != null) {
            if (param.value is List) {
              for (var p in param.value) {
                whereArguments.add(p);
              }
            } else {
              whereArguments.add(param.value);
            }
          }
          if (param.value2 != null) {
            whereArguments.add(param.value2);
          }
        }
      } else {
        whereString += param.whereString;
      }
    }
    if (Product._softDeleteActivated) {
      if (whereString != '') {
        whereString =
            '${!_getIsDeleted ? 'ifnull(isDeleted,0)=0 AND' : ''} ($whereString)';
      } else if (!_getIsDeleted) {
        whereString = 'ifnull(isDeleted,0)=0';
      }
    }

    if (whereString != '') {
      qparams.whereString = whereString;
    }
    qparams
      ..whereArguments = whereArguments
      ..groupBy = groupByList.join(',')
      ..orderBy = orderByList.join(',')
      ..having = havingList.join(',');
  }

  /// Deletes List<Product> bulk by query
  ///
  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted
  Future<BoolResult> delete([bool hardDelete = false]) async {
    _buildParameters();
    var r = BoolResult(success: false);

    if (Product._softDeleteActivated && !hardDelete) {
      r = await _obj!._mnProduct.updateBatch(qparams, {'isDeleted': 1});
    } else {
      r = await _obj!._mnProduct.delete(qparams);
    }
    return r;
  }

  /// Recover List<Product> bulk by query
  Future<BoolResult> recover() async {
    _getIsDeleted = true;
    _buildParameters();
    print('SQFENTITIY: recover Product bulk invoked');
    return _obj!._mnProduct.updateBatch(qparams, {'isDeleted': 0});
  }

  /// using:
  ///
  /// update({'fieldName': Value})
  ///
  /// fieldName must be String. Value is dynamic, it can be any of the (int, bool, String.. )
  Future<BoolResult> update(Map<String, dynamic> values) {
    _buildParameters();
    if (qparams.limit! > 0 || qparams.offset! > 0) {
      qparams.whereString =
          'id IN (SELECT id from product ${qparams.whereString!.isNotEmpty ? 'WHERE ${qparams.whereString}' : ''}${qparams.limit! > 0 ? ' LIMIT ${qparams.limit}' : ''}${qparams.offset! > 0 ? ' OFFSET ${qparams.offset}' : ''})';
    }
    return _obj!._mnProduct.updateBatch(qparams, values);
  }

  /// This method always returns Product Obj if exist, otherwise returns null
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: toSingle(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: toSingle(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>List<Product>
  Future<Product?> toSingle(
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    _pagesize = 1;
    _buildParameters();
    final objFuture = _obj!._mnProduct.toList(qparams);
    final data = await objFuture;
    Product? obj;
    if (data.isNotEmpty) {
      obj = Product.fromMap(data[0] as Map<String, dynamic>);
      // final List<String> _loadedFields = loadedFields ?? [];

      // RELATIONSHIPS PRELOAD
      if (preload || loadParents) {
        loadedFields = loadedFields ?? [];
        if (/*!_loadedfields!.contains('category.plCategory') && */ (preloadFields ==
                null ||
            loadParents ||
            preloadFields.contains('plCategory'))) {
          /*_loadedfields!.add('category.plCategory');*/ obj.plCategory = obj
                  .plCategory ??
              await obj.getCategory(
                  loadParents: loadParents /*, loadedFields: _loadedFields*/);
        }
      } // END RELATIONSHIPS PRELOAD

    } else {
      obj = null;
    }
    return obj;
  }

  /// This method returns int. [Product]
  ///
  /// <returns>int
  Future<int> toCount([VoidCallback Function(int c)? productCount]) async {
    _buildParameters();
    qparams.selectColumns = ['COUNT(1) AS CNT'];
    final productsFuture = await _obj!._mnProduct.toList(qparams);
    final int count = productsFuture[0]['CNT'] as int;
    if (productCount != null) {
      productCount(count);
    }
    return count;
  }

  /// This method returns List<Product> [Product]
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: toList(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: toList(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>List<Product>
  Future<List<Product>> toList(
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    final data = await toMapList();
    final List<Product> productsData = await Product.fromMapList(data,
        preload: preload,
        preloadFields: preloadFields,
        loadParents: loadParents,
        loadedFields: loadedFields,
        setDefaultValues: qparams.selectColumns == null);
    return productsData;
  }

  /// This method returns Json String [Product]
  Future<String> toJson() async {
    final list = <dynamic>[];
    final data = await toList();
    for (var o in data) {
      list.add(o.toMap(forJson: true));
    }
    return json.encode(list);
  }

  /// This method returns Json String. [Product]
  Future<String> toJsonWithChilds() async {
    final list = <dynamic>[];
    final data = await toList();
    for (var o in data) {
      list.add(await o.toMapWithChildren(false, true));
    }
    return json.encode(list);
  }

  /// This method returns List<dynamic>. [Product]
  ///
  /// <returns>List<dynamic>
  Future<List<dynamic>> toMapList() async {
    _buildParameters();
    return await _obj!._mnProduct.toList(qparams);
  }

  /// Returns List<DropdownMenuItem<Product>>
  Future<List<DropdownMenuItem<Product>>> toDropDownMenu(
      String displayTextColumn,
      [VoidCallback Function(List<DropdownMenuItem<Product>> o)?
          dropDownMenu]) async {
    _buildParameters();
    final productsFuture = _obj!._mnProduct.toList(qparams);

    final data = await productsFuture;
    final int count = data.length;
    final List<DropdownMenuItem<Product>> items = []..add(DropdownMenuItem(
        value: Product(),
        child: Text('Select Product'),
      ));
    for (int i = 0; i < count; i++) {
      items.add(
        DropdownMenuItem(
          value: Product.fromMap(data[i] as Map<String, dynamic>),
          child: Text(data[i][displayTextColumn].toString()),
        ),
      );
    }
    if (dropDownMenu != null) {
      dropDownMenu(items);
    }
    return items;
  }

  /// Returns List<DropdownMenuItem<int>>
  Future<List<DropdownMenuItem<int>>> toDropDownMenuInt(
      String displayTextColumn,
      [VoidCallback Function(List<DropdownMenuItem<int>> o)?
          dropDownMenu]) async {
    _buildParameters();
    qparams.selectColumns = ['id', displayTextColumn];
    final productsFuture = _obj!._mnProduct.toList(qparams);

    final data = await productsFuture;
    final int count = data.length;
    final List<DropdownMenuItem<int>> items = []..add(DropdownMenuItem(
        value: 0,
        child: Text('Select Product'),
      ));
    for (int i = 0; i < count; i++) {
      items.add(
        DropdownMenuItem(
          value: data[i]['id'] as int,
          child: Text(data[i][displayTextColumn].toString()),
        ),
      );
    }
    if (dropDownMenu != null) {
      dropDownMenu(items);
    }
    return items;
  }

  /// This method returns Primary Key List SQL and Parameters retVal = Map<String,dynamic>. [Product]
  ///
  /// retVal['sql'] = SQL statement string, retVal['args'] = whereArguments List<dynamic>;
  ///
  /// <returns>List<String>
  Map<String, dynamic> toListPrimaryKeySQL([bool buildParameters = true]) {
    final Map<String, dynamic> _retVal = <String, dynamic>{};
    if (buildParameters) {
      _buildParameters();
    }
    _retVal['sql'] = 'SELECT `id` FROM product WHERE ${qparams.whereString}';
    _retVal['args'] = qparams.whereArguments;
    return _retVal;
  }

  /// This method returns Primary Key List<int>.
  /// <returns>List<int>
  Future<List<int>> toListPrimaryKey([bool buildParameters = true]) async {
    if (buildParameters) {
      _buildParameters();
    }
    final List<int> idData = <int>[];
    qparams.selectColumns = ['id'];
    final idFuture = await _obj!._mnProduct.toList(qparams);

    final int count = idFuture.length;
    for (int i = 0; i < count; i++) {
      idData.add(idFuture[i]['id'] as int);
    }
    return idData;
  }

  /// Returns List<dynamic> for selected columns. Use this method for 'groupBy' with min,max,avg..  [Product]
  ///
  /// Sample usage: (see EXAMPLE 4.2 at https://github.com/hhtokpinar/sqfEntity#group-by)
  Future<List<dynamic>> toListObject() async {
    _buildParameters();

    final objectFuture = _obj!._mnProduct.toList(qparams);

    final List<dynamic> objectsData = <dynamic>[];
    final data = await objectFuture;
    final int count = data.length;
    for (int i = 0; i < count; i++) {
      objectsData.add(data[i]);
    }
    return objectsData;
  }

  /// Returns List<String> for selected first column
  ///
  /// Sample usage: await Product.select(columnsToSelect: ['columnName']).toListString()
  Future<List<String>> toListString(
      [VoidCallback Function(List<String> o)? listString]) async {
    _buildParameters();

    final objectFuture = _obj!._mnProduct.toList(qparams);

    final List<String> objectsData = <String>[];
    final data = await objectFuture;
    final int count = data.length;
    for (int i = 0; i < count; i++) {
      objectsData.add(data[i][qparams.selectColumns![0]].toString());
    }
    if (listString != null) {
      listString(objectsData);
    }
    return objectsData;
  }
}
// endregion ProductFilterBuilder

// region ProductFields
class ProductFields {
  static TableField? _fId;
  static TableField get id {
    return _fId = _fId ?? SqlSyntax.setField(_fId, 'id', DbType.integer);
  }

  static TableField? _fName;
  static TableField get name {
    return _fName = _fName ?? SqlSyntax.setField(_fName, 'name', DbType.text);
  }

  static TableField? _fDescription;
  static TableField get description {
    return _fDescription = _fDescription ??
        SqlSyntax.setField(_fDescription, 'description', DbType.text);
  }

  static TableField? _fPrice;
  static TableField get price {
    return _fPrice =
        _fPrice ?? SqlSyntax.setField(_fPrice, 'price', DbType.real);
  }

  static TableField? _fIsActive;
  static TableField get isActive {
    return _fIsActive =
        _fIsActive ?? SqlSyntax.setField(_fIsActive, 'isActive', DbType.bool);
  }

  static TableField? _fCategoryId;
  static TableField get categoryId {
    return _fCategoryId = _fCategoryId ??
        SqlSyntax.setField(_fCategoryId, 'categoryId', DbType.integer);
  }

  static TableField? _fRownum;
  static TableField get rownum {
    return _fRownum =
        _fRownum ?? SqlSyntax.setField(_fRownum, 'rownum', DbType.integer);
  }

  static TableField? _fImageUrl;
  static TableField get imageUrl {
    return _fImageUrl =
        _fImageUrl ?? SqlSyntax.setField(_fImageUrl, 'imageUrl', DbType.text);
  }

  static TableField? _fDatetime;
  static TableField get datetime {
    return _fDatetime = _fDatetime ??
        SqlSyntax.setField(_fDatetime, 'datetime', DbType.datetime);
  }

  static TableField? _fDate;
  static TableField get date {
    return _fDate = _fDate ?? SqlSyntax.setField(_fDate, 'date', DbType.date);
  }

  static TableField? _fDateCreated;
  static TableField get dateCreated {
    return _fDateCreated = _fDateCreated ??
        SqlSyntax.setField(_fDateCreated, 'dateCreated', DbType.datetime);
  }

  static TableField? _fIsDeleted;
  static TableField get isDeleted {
    return _fIsDeleted = _fIsDeleted ??
        SqlSyntax.setField(_fIsDeleted, 'isDeleted', DbType.integer);
  }
}
// endregion ProductFields

//region ProductManager
class ProductManager extends SqfEntityProvider {
  ProductManager()
      : super(MyDbModel(),
            tableName: _tableName,
            primaryKeyList: _primaryKeyList,
            whereStr: _whereStr);
  static final String _tableName = 'product';
  static final List<String> _primaryKeyList = ['id'];
  static final String _whereStr = 'id=?';
}

//endregion ProductManager
// region Category
class Category extends TableBase {
  Category({this.id, this.name, this.isActive}) {
    _setDefaultValues();
  }
  Category.withFields(this.name, this.isActive) {
    _setDefaultValues();
  }
  Category.withId(this.id, this.name, this.isActive) {
    _setDefaultValues();
  }
  // fromMap v2.0
  Category.fromMap(Map<String, dynamic> o, {bool setDefaultValues = true}) {
    if (setDefaultValues) {
      _setDefaultValues();
    }
    id = int.tryParse(o['id'].toString());
    if (o['name'] != null) {
      name = o['name'].toString();
    }
    if (o['isActive'] != null) {
      isActive =
          o['isActive'].toString() == '1' || o['isActive'].toString() == 'true';
    }
  }
  // FIELDS (Category)
  int? id;
  String? name;
  bool? isActive;

  BoolResult? saveResult;
  // end FIELDS (Category)

// COLLECTIONS & VIRTUALS (Category)
  /// to load children of items to this field, use preload parameter. Ex: toList(preload:true) or toSingle(preload:true) or getById(preload:true)
  /// You can also specify this object into certain preload fields!. Ex: toList(preload:true, preloadFields:['plProducts', 'plField2'..]) or so on..
  List<Product>? plProducts;

  /// get Product(s) filtered by id=categoryId
  ProductFilterBuilder? getProducts(
      {List<String>? columnsToSelect, bool? getIsDeleted}) {
    if (id == null) {
      return null;
    }
    return Product()
        .select(columnsToSelect: columnsToSelect, getIsDeleted: getIsDeleted)
        .categoryId
        .equals(id)
        .and;
  }

// END COLLECTIONS & VIRTUALS (Category)

  static const bool _softDeleteActivated = false;
  CategoryManager? __mnCategory;

  CategoryManager get _mnCategory {
    return __mnCategory = __mnCategory ?? CategoryManager();
  }

  // METHODS
  Map<String, dynamic> toMap(
      {bool forQuery = false, bool forJson = false, bool forView = false}) {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    if (name != null) {
      map['name'] = name;
    }

    if (isActive != null) {
      map['isActive'] = forQuery ? (isActive! ? 1 : 0) : isActive;
    }

    return map;
  }

  Future<Map<String, dynamic>> toMapWithChildren(
      [bool forQuery = false,
      bool forJson = false,
      bool forView = false]) async {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    if (name != null) {
      map['name'] = name;
    }

    if (isActive != null) {
      map['isActive'] = forQuery ? (isActive! ? 1 : 0) : isActive;
    }

// COLLECTIONS (Category)
    if (!forQuery) {
      map['Products'] = await getProducts()!.toMapList();
    }
// END COLLECTIONS (Category)

    return map;
  }

  /// This method returns Json String [Category]
  String toJson() {
    return json.encode(toMap(forJson: true));
  }

  /// This method returns Json String [Category]
  Future<String> toJsonWithChilds() async {
    return json.encode(await toMapWithChildren(false, true));
  }

  List<dynamic> toArgs() {
    return [name, isActive];
  }

  List<dynamic> toArgsWithIds() {
    return [id, name, isActive];
  }

  static Future<List<Category>?> fromWebUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      return await fromJson(response.body);
    } catch (e) {
      print(
          'SQFENTITY ERROR Category.fromWebUrl: ErrorMessage: ${e.toString()}');
      return null;
    }
  }

  Future<http.Response> postUrl(Uri uri, {Map<String, String>? headers}) {
    return http.post(uri, headers: headers, body: toJson());
  }

  static Future<List<Category>> fromJson(String jsonBody) async {
    final Iterable list = await json.decode(jsonBody) as Iterable;
    var objList = <Category>[];
    try {
      objList = list
          .map((category) => Category.fromMap(category as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('SQFENTITY ERROR Category.fromJson: ErrorMessage: ${e.toString()}');
    }
    return objList;
  }

  static Future<List<Category>> fromMapList(List<dynamic> data,
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields,
      bool setDefaultValues = true}) async {
    final List<Category> objList = <Category>[];
    loadedFields = loadedFields ?? [];
    for (final map in data) {
      final obj = Category.fromMap(map as Map<String, dynamic>,
          setDefaultValues: setDefaultValues);
      // final List<String> _loadedFields = List<String>.from(loadedFields);

      // RELATIONSHIPS PRELOAD CHILD
      if (preload) {
        loadedFields = loadedFields ?? [];
        if (/*!_loadedfields!.contains('category.plProducts') && */ (preloadFields ==
                null ||
            preloadFields.contains('plProducts'))) {
          /*_loadedfields!.add('category.plProducts'); */ obj.plProducts =
              obj.plProducts ??
                  await obj.getProducts()!.toList(
                      preload: preload,
                      preloadFields: preloadFields,
                      loadParents: false /*, loadedFields:_loadedFields*/);
        }
      } // END RELATIONSHIPS PRELOAD CHILD

      objList.add(obj);
    }
    return objList;
  }

  /// returns Category by ID if exist, otherwise returns null
  ///
  /// Primary Keys: int? id
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: getById(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: getById(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>returns Category if exist, otherwise returns null
  Future<Category?> getById(int? id,
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    if (id == null) {
      return null;
    }
    Category? obj;
    final data = await _mnCategory.getById([id]);
    if (data.length != 0) {
      obj = Category.fromMap(data[0] as Map<String, dynamic>);
      // final List<String> _loadedFields = loadedFields ?? [];

      // RELATIONSHIPS PRELOAD CHILD
      if (preload) {
        loadedFields = loadedFields ?? [];
        if (/*!_loadedfields!.contains('category.plProducts') && */ (preloadFields ==
                null ||
            preloadFields.contains('plProducts'))) {
          /*_loadedfields!.add('category.plProducts'); */ obj.plProducts =
              obj.plProducts ??
                  await obj.getProducts()!.toList(
                      preload: preload,
                      preloadFields: preloadFields,
                      loadParents: false /*, loadedFields:_loadedFields*/);
        }
      } // END RELATIONSHIPS PRELOAD CHILD

    } else {
      obj = null;
    }
    return obj;
  }

  /// Saves the (Category) object. If the id field is null, saves as a new record and returns new id, if id is not null then updates record
  /// ignoreBatch = true as a default. Set ignoreBatch to false if you run more than one save() operation those are between batchStart and batchCommit
  /// <returns>Returns id
  Future<int?> save({bool ignoreBatch = true}) async {
    if (id == null || id == 0) {
      id = await _mnCategory.insert(this, ignoreBatch);
    } else {
      // id= await _upsert(); // removed in sqfentity_gen 1.3.0+6
      await _mnCategory.update(this);
    }

    return id;
  }

  /// Saves the (Category) object. If the id field is null, saves as a new record and returns new id, if id is not null then updates record
  ///
  /// ignoreBatch = true as a default. Set ignoreBatch to false if you run more than one save() operation those are between batchStart and batchCommit
  ///
  /// <returns>Returns id
  Future<int?> saveOrThrow({bool ignoreBatch = true}) async {
    if (id == null || id == 0) {
      id = await _mnCategory.insertOrThrow(this, ignoreBatch);

      isInsert = true;
    } else {
      // id= await _upsert(); // removed in sqfentity_gen 1.3.0+6
      await _mnCategory.updateOrThrow(this);
    }

    return id;
  }

  /// saveAs Category. Returns a new Primary Key value of Category

  /// <returns>Returns a new Primary Key value of Category
  Future<int?> saveAs() async {
    id = null;

    return save();
  }

  void rollbackId() {
    if (isInsert == true) {
      id = null;
    }
  }

  /// saveAll method saves the sent List<Category> as a bulk in one transaction
  ///
  /// Returns a <List<BoolResult>>
  static Future<List<dynamic>> saveAll(List<Category> categories) async {
    // final results = _mnCategory.saveAll('INSERT OR REPLACE INTO category (id, name, isActive)  VALUES (?,?,?)',categories);
    // return results; removed in sqfentity_gen 1.3.0+6
    await MyDbModel().batchStart();
    for (final obj in categories) {
      await obj.save(ignoreBatch: false);
    }
    //    return MyDbModel().batchCommit();
    final result = await MyDbModel().batchCommit();
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].id == null) {
        categories[i].id = result![i] as int;
      }
    }

    return result!;
  }

  /// Updates if the record exists, otherwise adds a new row

  /// <returns>Returns id

  Future<int?> upsert() async {
    try {
      final result = await _mnCategory.rawInsert(
          'INSERT OR REPLACE INTO category (id, name, isActive)  VALUES (?,?,?)',
          [id, name, isActive]);
      if (result! > 0) {
        saveResult = BoolResult(
            success: true,
            successMessage: 'Category id=$id updated successfully');
      } else {
        saveResult = BoolResult(
            success: false, errorMessage: 'Category id=$id did not update');
      }
      return id;
    } catch (e) {
      saveResult = BoolResult(
          success: false,
          errorMessage: 'Category Save failed. Error: ${e.toString()}');
      return null;
    }
  }

  /// inserts or replaces the sent List<<Category>> as a bulk in one transaction.
  ///
  /// upsertAll() method is faster then saveAll() method. upsertAll() should be used when you are sure that the primary key is greater than zero
  ///
  /// Returns a BoolCommitResult
  Future<BoolCommitResult> upsertAll(List<Category> categories) async {
    final results = await _mnCategory.rawInsertAll(
        'INSERT OR REPLACE INTO category (id, name, isActive)  VALUES (?,?,?)',
        categories);
    return results;
  }

  /// Deletes Category

  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted

  Future<BoolResult> delete([bool hardDelete = false]) async {
    print('SQFENTITIY: delete Category invoked (id=$id)');
    var result = BoolResult(success: false);
    {
      result =
          await Product().select().categoryId.equals(id).and.delete(hardDelete);
    }
    if (!result.success) {
      return result;
    }
    if (!_softDeleteActivated || hardDelete) {
      return _mnCategory
          .delete(QueryParams(whereString: 'id=?', whereArguments: [id]));
    } else {
      return _mnCategory.updateBatch(
          QueryParams(whereString: 'id=?', whereArguments: [id]),
          {'isDeleted': 1});
    }
  }

  CategoryFilterBuilder select(
      {List<String>? columnsToSelect, bool? getIsDeleted}) {
    return CategoryFilterBuilder(this)
      .._getIsDeleted = getIsDeleted == true
      ..qparams.selectColumns = columnsToSelect;
  }

  CategoryFilterBuilder distinct(
      {List<String>? columnsToSelect, bool? getIsDeleted}) {
    return CategoryFilterBuilder(this)
      .._getIsDeleted = getIsDeleted == true
      ..qparams.selectColumns = columnsToSelect
      ..qparams.distinct = true;
  }

  void _setDefaultValues() {
    isActive = isActive ?? true;
  }
  // END METHODS
  // BEGIN CUSTOM CODE
  /*
      you can define customCode property of your SqfEntityTable constant. For example:
      const tablePerson = SqfEntityTable(
      tableName: 'person',
      primaryKeyName: 'id',
      primaryKeyType: PrimaryKeyType.integer_auto_incremental,
      fields: [
        SqfEntityField('firstName', DbType.text),
        SqfEntityField('lastName', DbType.text),
      ],
      customCode: '''
       String fullName()
       { 
         return '$firstName $lastName';
       }
      ''');
     */
  // END CUSTOM CODE
}
// endregion category

// region CategoryField
class CategoryField extends SearchCriteria {
  CategoryField(this.categoryFB);
  // { param = DbParameter(); }
  DbParameter param = DbParameter();
  String _waitingNot = '';
  CategoryFilterBuilder categoryFB;

  CategoryField get not {
    _waitingNot = ' NOT ';
    return this;
  }

  CategoryFilterBuilder equals(dynamic pValue) {
    param.expression = '=';
    categoryFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, categoryFB.parameters, param, SqlSyntax.EQuals,
            categoryFB._addedBlocks)
        : setCriteria(pValue, categoryFB.parameters, param, SqlSyntax.NotEQuals,
            categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder equalsOrNull(dynamic pValue) {
    param.expression = '=';
    categoryFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.EQualsOrNull, categoryFB._addedBlocks)
        : setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.NotEQualsOrNull, categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder isNull() {
    categoryFB._addedBlocks = setCriteria(
        0,
        categoryFB.parameters,
        param,
        SqlSyntax.IsNULL.replaceAll(SqlSyntax.notKeyword, _waitingNot),
        categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder contains(dynamic pValue) {
    if (pValue != null) {
      categoryFB._addedBlocks = setCriteria(
          '%${pValue.toString()}%',
          categoryFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          categoryFB._addedBlocks);
      _waitingNot = '';
      categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
          categoryFB._addedBlocks.retVal;
    }
    return categoryFB;
  }

  CategoryFilterBuilder startsWith(dynamic pValue) {
    if (pValue != null) {
      categoryFB._addedBlocks = setCriteria(
          '${pValue.toString()}%',
          categoryFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          categoryFB._addedBlocks);
      _waitingNot = '';
      categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
          categoryFB._addedBlocks.retVal;
      categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
          categoryFB._addedBlocks.retVal;
    }
    return categoryFB;
  }

  CategoryFilterBuilder endsWith(dynamic pValue) {
    if (pValue != null) {
      categoryFB._addedBlocks = setCriteria(
          '%${pValue.toString()}',
          categoryFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          categoryFB._addedBlocks);
      _waitingNot = '';
      categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
          categoryFB._addedBlocks.retVal;
    }
    return categoryFB;
  }

  CategoryFilterBuilder between(dynamic pFirst, dynamic pLast) {
    if (pFirst != null && pLast != null) {
      categoryFB._addedBlocks = setCriteria(
          pFirst,
          categoryFB.parameters,
          param,
          SqlSyntax.Between.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          categoryFB._addedBlocks,
          pLast);
    } else if (pFirst != null) {
      if (_waitingNot != '') {
        categoryFB._addedBlocks = setCriteria(pFirst, categoryFB.parameters,
            param, SqlSyntax.LessThan, categoryFB._addedBlocks);
      } else {
        categoryFB._addedBlocks = setCriteria(pFirst, categoryFB.parameters,
            param, SqlSyntax.GreaterThanOrEquals, categoryFB._addedBlocks);
      }
    } else if (pLast != null) {
      if (_waitingNot != '') {
        categoryFB._addedBlocks = setCriteria(pLast, categoryFB.parameters,
            param, SqlSyntax.GreaterThan, categoryFB._addedBlocks);
      } else {
        categoryFB._addedBlocks = setCriteria(pLast, categoryFB.parameters,
            param, SqlSyntax.LessThanOrEquals, categoryFB._addedBlocks);
      }
    }
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder greaterThan(dynamic pValue) {
    param.expression = '>';
    categoryFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.GreaterThan, categoryFB._addedBlocks)
        : setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.LessThanOrEquals, categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder lessThan(dynamic pValue) {
    param.expression = '<';
    categoryFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, categoryFB.parameters, param, SqlSyntax.LessThan,
            categoryFB._addedBlocks)
        : setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.GreaterThanOrEquals, categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder greaterThanOrEquals(dynamic pValue) {
    param.expression = '>=';
    categoryFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.GreaterThanOrEquals, categoryFB._addedBlocks)
        : setCriteria(pValue, categoryFB.parameters, param, SqlSyntax.LessThan,
            categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder lessThanOrEquals(dynamic pValue) {
    param.expression = '<=';
    categoryFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.LessThanOrEquals, categoryFB._addedBlocks)
        : setCriteria(pValue, categoryFB.parameters, param,
            SqlSyntax.GreaterThan, categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }

  CategoryFilterBuilder inValues(dynamic pValue) {
    categoryFB._addedBlocks = setCriteria(
        pValue,
        categoryFB.parameters,
        param,
        SqlSyntax.IN.replaceAll(SqlSyntax.notKeyword, _waitingNot),
        categoryFB._addedBlocks);
    _waitingNot = '';
    categoryFB._addedBlocks.needEndBlock![categoryFB._blockIndex] =
        categoryFB._addedBlocks.retVal;
    return categoryFB;
  }
}
// endregion CategoryField

// region CategoryFilterBuilder
class CategoryFilterBuilder extends SearchCriteria {
  CategoryFilterBuilder(Category obj) {
    whereString = '';
    groupByList = <String>[];
    _addedBlocks.needEndBlock!.add(false);
    _addedBlocks.waitingStartBlock!.add(false);
    _obj = obj;
  }
  AddedBlocks _addedBlocks = AddedBlocks(<bool>[], <bool>[]);
  int _blockIndex = 0;
  List<DbParameter> parameters = <DbParameter>[];
  List<String> orderByList = <String>[];
  Category? _obj;
  QueryParams qparams = QueryParams();
  int _pagesize = 0;
  int _page = 0;

  /// put the sql keyword 'AND'
  CategoryFilterBuilder get and {
    if (parameters.isNotEmpty) {
      parameters[parameters.length - 1].wOperator = ' AND ';
    }
    return this;
  }

  /// put the sql keyword 'OR'
  CategoryFilterBuilder get or {
    if (parameters.isNotEmpty) {
      parameters[parameters.length - 1].wOperator = ' OR ';
    }
    return this;
  }

  /// open parentheses
  CategoryFilterBuilder get startBlock {
    _addedBlocks.waitingStartBlock!.add(true);
    _addedBlocks.needEndBlock!.add(false);
    _blockIndex++;
    if (_blockIndex > 1) {
      _addedBlocks.needEndBlock![_blockIndex - 1] = true;
    }
    return this;
  }

  /// String whereCriteria, write raw query without 'where' keyword. Like this: 'field1 like 'test%' and field2 = 3'
  CategoryFilterBuilder where(String? whereCriteria, {dynamic parameterValue}) {
    if (whereCriteria != null && whereCriteria != '') {
      final DbParameter param = DbParameter(
          columnName: parameterValue == null ? null : '',
          hasParameter: parameterValue != null);
      _addedBlocks = setCriteria(parameterValue ?? 0, parameters, param,
          '($whereCriteria)', _addedBlocks);
      _addedBlocks.needEndBlock![_blockIndex] = _addedBlocks.retVal;
    }
    return this;
  }

  /// page = page number,
  ///
  /// pagesize = row(s) per page
  CategoryFilterBuilder page(int page, int pagesize) {
    if (page > 0) {
      _page = page;
    }
    if (pagesize > 0) {
      _pagesize = pagesize;
    }
    return this;
  }

  /// int count = LIMIT
  CategoryFilterBuilder top(int count) {
    if (count > 0) {
      _pagesize = count;
    }
    return this;
  }

  /// close parentheses
  CategoryFilterBuilder get endBlock {
    if (_addedBlocks.needEndBlock![_blockIndex]) {
      parameters[parameters.length - 1].whereString += ' ) ';
    }
    _addedBlocks.needEndBlock!.removeAt(_blockIndex);
    _addedBlocks.waitingStartBlock!.removeAt(_blockIndex);
    _blockIndex--;
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='name, date'
  ///
  /// Example 2: argFields = ['name', 'date']
  CategoryFilterBuilder orderBy(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        orderByList.add(argFields);
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            orderByList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='field1, field2'
  ///
  /// Example 2: argFields = ['field1', 'field2']
  CategoryFilterBuilder orderByDesc(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        orderByList.add('$argFields desc ');
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            orderByList.add(' $s desc ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='field1, field2'
  ///
  /// Example 2: argFields = ['field1', 'field2']
  CategoryFilterBuilder groupBy(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        groupByList.add(' $argFields ');
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            groupByList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='name, date'
  ///
  /// Example 2: argFields = ['name', 'date']
  CategoryFilterBuilder having(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        havingList.add(argFields);
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            havingList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  CategoryField setField(CategoryField? field, String colName, DbType dbtype) {
    return CategoryField(this)
      ..param = DbParameter(
          dbType: dbtype,
          columnName: colName,
          wStartBlock: _addedBlocks.waitingStartBlock![_blockIndex]);
  }

  CategoryField? _id;
  CategoryField get id {
    return _id = setField(_id, 'id', DbType.integer);
  }

  CategoryField? _name;
  CategoryField get name {
    return _name = setField(_name, 'name', DbType.text);
  }

  CategoryField? _isActive;
  CategoryField get isActive {
    return _isActive = setField(_isActive, 'isActive', DbType.bool);
  }

  bool _getIsDeleted = false;

  void _buildParameters() {
    if (_page > 0 && _pagesize > 0) {
      qparams
        ..limit = _pagesize
        ..offset = (_page - 1) * _pagesize;
    } else {
      qparams
        ..limit = _pagesize
        ..offset = _page;
    }
    for (DbParameter param in parameters) {
      if (param.columnName != null) {
        if (param.value is List && !param.hasParameter) {
          param.value = param.dbType == DbType.text || param.value[0] is String
              ? '\'${param.value.join('\',\'')}\''
              : param.value.join(',');
          whereString += param.whereString
              .replaceAll('{field}', param.columnName!)
              .replaceAll('?', param.value.toString());
          param.value = null;
        } else {
          if (param.value is Map<String, dynamic> &&
              param.value['sql'] != null) {
            param
              ..whereString = param.whereString
                  .replaceAll('?', param.value['sql'].toString())
              ..dbType = DbType.integer
              ..value = param.value['args'];
          }
          whereString +=
              param.whereString.replaceAll('{field}', param.columnName!);
        }
        if (!param.whereString.contains('?')) {
        } else {
          switch (param.dbType) {
            case DbType.bool:
              param.value = param.value == null
                  ? null
                  : param.value == true
                      ? 1
                      : 0;
              param.value2 = param.value2 == null
                  ? null
                  : param.value2 == true
                      ? 1
                      : 0;
              break;
            case DbType.date:
            case DbType.datetime:
            case DbType.datetimeUtc:
              param.value = param.value == null
                  ? null
                  : (param.value as DateTime).millisecondsSinceEpoch;
              param.value2 = param.value2 == null
                  ? null
                  : (param.value2 as DateTime).millisecondsSinceEpoch;
              break;
            default:
          }
          if (param.value != null) {
            if (param.value is List) {
              for (var p in param.value) {
                whereArguments.add(p);
              }
            } else {
              whereArguments.add(param.value);
            }
          }
          if (param.value2 != null) {
            whereArguments.add(param.value2);
          }
        }
      } else {
        whereString += param.whereString;
      }
    }
    if (Category._softDeleteActivated) {
      if (whereString != '') {
        whereString =
            '${!_getIsDeleted ? 'ifnull(isDeleted,0)=0 AND' : ''} ($whereString)';
      } else if (!_getIsDeleted) {
        whereString = 'ifnull(isDeleted,0)=0';
      }
    }

    if (whereString != '') {
      qparams.whereString = whereString;
    }
    qparams
      ..whereArguments = whereArguments
      ..groupBy = groupByList.join(',')
      ..orderBy = orderByList.join(',')
      ..having = havingList.join(',');
  }

  /// Deletes List<Category> bulk by query
  ///
  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted
  Future<BoolResult> delete([bool hardDelete = false]) async {
    _buildParameters();
    var r = BoolResult(success: false);
    // Delete sub records where in (Product) according to DeleteRule.CASCADE
    final idListProductBYcategoryId = toListPrimaryKeySQL(false);
    final resProductBYcategoryId = await Product()
        .select()
        .where('categoryId IN (${idListProductBYcategoryId['sql']})',
            parameterValue: idListProductBYcategoryId['args'])
        .delete(hardDelete);
    if (!resProductBYcategoryId.success) {
      return resProductBYcategoryId;
    }

    if (Category._softDeleteActivated && !hardDelete) {
      r = await _obj!._mnCategory.updateBatch(qparams, {'isDeleted': 1});
    } else {
      r = await _obj!._mnCategory.delete(qparams);
    }
    return r;
  }

  /// using:
  ///
  /// update({'fieldName': Value})
  ///
  /// fieldName must be String. Value is dynamic, it can be any of the (int, bool, String.. )
  Future<BoolResult> update(Map<String, dynamic> values) {
    _buildParameters();
    if (qparams.limit! > 0 || qparams.offset! > 0) {
      qparams.whereString =
          'id IN (SELECT id from category ${qparams.whereString!.isNotEmpty ? 'WHERE ${qparams.whereString}' : ''}${qparams.limit! > 0 ? ' LIMIT ${qparams.limit}' : ''}${qparams.offset! > 0 ? ' OFFSET ${qparams.offset}' : ''})';
    }
    return _obj!._mnCategory.updateBatch(qparams, values);
  }

  /// This method always returns Category Obj if exist, otherwise returns null
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: toSingle(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: toSingle(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>List<Category>
  Future<Category?> toSingle(
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    _pagesize = 1;
    _buildParameters();
    final objFuture = _obj!._mnCategory.toList(qparams);
    final data = await objFuture;
    Category? obj;
    if (data.isNotEmpty) {
      obj = Category.fromMap(data[0] as Map<String, dynamic>);
      // final List<String> _loadedFields = loadedFields ?? [];

      // RELATIONSHIPS PRELOAD CHILD
      if (preload) {
        loadedFields = loadedFields ?? [];
        if (/*!_loadedfields!.contains('category.plProducts') && */ (preloadFields ==
                null ||
            preloadFields.contains('plProducts'))) {
          /*_loadedfields!.add('category.plProducts'); */ obj.plProducts =
              obj.plProducts ??
                  await obj.getProducts()!.toList(
                      preload: preload,
                      preloadFields: preloadFields,
                      loadParents: false /*, loadedFields:_loadedFields*/);
        }
      } // END RELATIONSHIPS PRELOAD CHILD

    } else {
      obj = null;
    }
    return obj;
  }

  /// This method returns int. [Category]
  ///
  /// <returns>int
  Future<int> toCount([VoidCallback Function(int c)? categoryCount]) async {
    _buildParameters();
    qparams.selectColumns = ['COUNT(1) AS CNT'];
    final categoriesFuture = await _obj!._mnCategory.toList(qparams);
    final int count = categoriesFuture[0]['CNT'] as int;
    if (categoryCount != null) {
      categoryCount(count);
    }
    return count;
  }

  /// This method returns List<Category> [Category]
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: toList(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: toList(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>List<Category>
  Future<List<Category>> toList(
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    final data = await toMapList();
    final List<Category> categoriesData = await Category.fromMapList(data,
        preload: preload,
        preloadFields: preloadFields,
        loadParents: loadParents,
        loadedFields: loadedFields,
        setDefaultValues: qparams.selectColumns == null);
    return categoriesData;
  }

  /// This method returns Json String [Category]
  Future<String> toJson() async {
    final list = <dynamic>[];
    final data = await toList();
    for (var o in data) {
      list.add(o.toMap(forJson: true));
    }
    return json.encode(list);
  }

  /// This method returns Json String. [Category]
  Future<String> toJsonWithChilds() async {
    final list = <dynamic>[];
    final data = await toList();
    for (var o in data) {
      list.add(await o.toMapWithChildren(false, true));
    }
    return json.encode(list);
  }

  /// This method returns List<dynamic>. [Category]
  ///
  /// <returns>List<dynamic>
  Future<List<dynamic>> toMapList() async {
    _buildParameters();
    return await _obj!._mnCategory.toList(qparams);
  }

  /// Returns List<DropdownMenuItem<Category>>
  Future<List<DropdownMenuItem<Category>>> toDropDownMenu(
      String displayTextColumn,
      [VoidCallback Function(List<DropdownMenuItem<Category>> o)?
          dropDownMenu]) async {
    _buildParameters();
    final categoriesFuture = _obj!._mnCategory.toList(qparams);

    final data = await categoriesFuture;
    final int count = data.length;
    final List<DropdownMenuItem<Category>> items = []..add(DropdownMenuItem(
        value: Category(),
        child: Text('Select Category'),
      ));
    for (int i = 0; i < count; i++) {
      items.add(
        DropdownMenuItem(
          value: Category.fromMap(data[i] as Map<String, dynamic>),
          child: Text(data[i][displayTextColumn].toString()),
        ),
      );
    }
    if (dropDownMenu != null) {
      dropDownMenu(items);
    }
    return items;
  }

  /// Returns List<DropdownMenuItem<int>>
  Future<List<DropdownMenuItem<int>>> toDropDownMenuInt(
      String displayTextColumn,
      [VoidCallback Function(List<DropdownMenuItem<int>> o)?
          dropDownMenu]) async {
    _buildParameters();
    qparams.selectColumns = ['id', displayTextColumn];
    final categoriesFuture = _obj!._mnCategory.toList(qparams);

    final data = await categoriesFuture;
    final int count = data.length;
    final List<DropdownMenuItem<int>> items = []..add(DropdownMenuItem(
        value: 0,
        child: Text('Select Category'),
      ));
    for (int i = 0; i < count; i++) {
      items.add(
        DropdownMenuItem(
          value: data[i]['id'] as int,
          child: Text(data[i][displayTextColumn].toString()),
        ),
      );
    }
    if (dropDownMenu != null) {
      dropDownMenu(items);
    }
    return items;
  }

  /// This method returns Primary Key List SQL and Parameters retVal = Map<String,dynamic>. [Category]
  ///
  /// retVal['sql'] = SQL statement string, retVal['args'] = whereArguments List<dynamic>;
  ///
  /// <returns>List<String>
  Map<String, dynamic> toListPrimaryKeySQL([bool buildParameters = true]) {
    final Map<String, dynamic> _retVal = <String, dynamic>{};
    if (buildParameters) {
      _buildParameters();
    }
    _retVal['sql'] = 'SELECT `id` FROM category WHERE ${qparams.whereString}';
    _retVal['args'] = qparams.whereArguments;
    return _retVal;
  }

  /// This method returns Primary Key List<int>.
  /// <returns>List<int>
  Future<List<int>> toListPrimaryKey([bool buildParameters = true]) async {
    if (buildParameters) {
      _buildParameters();
    }
    final List<int> idData = <int>[];
    qparams.selectColumns = ['id'];
    final idFuture = await _obj!._mnCategory.toList(qparams);

    final int count = idFuture.length;
    for (int i = 0; i < count; i++) {
      idData.add(idFuture[i]['id'] as int);
    }
    return idData;
  }

  /// Returns List<dynamic> for selected columns. Use this method for 'groupBy' with min,max,avg..  [Category]
  ///
  /// Sample usage: (see EXAMPLE 4.2 at https://github.com/hhtokpinar/sqfEntity#group-by)
  Future<List<dynamic>> toListObject() async {
    _buildParameters();

    final objectFuture = _obj!._mnCategory.toList(qparams);

    final List<dynamic> objectsData = <dynamic>[];
    final data = await objectFuture;
    final int count = data.length;
    for (int i = 0; i < count; i++) {
      objectsData.add(data[i]);
    }
    return objectsData;
  }

  /// Returns List<String> for selected first column
  ///
  /// Sample usage: await Category.select(columnsToSelect: ['columnName']).toListString()
  Future<List<String>> toListString(
      [VoidCallback Function(List<String> o)? listString]) async {
    _buildParameters();

    final objectFuture = _obj!._mnCategory.toList(qparams);

    final List<String> objectsData = <String>[];
    final data = await objectFuture;
    final int count = data.length;
    for (int i = 0; i < count; i++) {
      objectsData.add(data[i][qparams.selectColumns![0]].toString());
    }
    if (listString != null) {
      listString(objectsData);
    }
    return objectsData;
  }
}
// endregion CategoryFilterBuilder

// region CategoryFields
class CategoryFields {
  static TableField? _fId;
  static TableField get id {
    return _fId = _fId ?? SqlSyntax.setField(_fId, 'id', DbType.integer);
  }

  static TableField? _fName;
  static TableField get name {
    return _fName = _fName ?? SqlSyntax.setField(_fName, 'name', DbType.text);
  }

  static TableField? _fIsActive;
  static TableField get isActive {
    return _fIsActive =
        _fIsActive ?? SqlSyntax.setField(_fIsActive, 'isActive', DbType.bool);
  }
}
// endregion CategoryFields

//region CategoryManager
class CategoryManager extends SqfEntityProvider {
  CategoryManager()
      : super(MyDbModel(),
            tableName: _tableName,
            primaryKeyList: _primaryKeyList,
            whereStr: _whereStr);
  static final String _tableName = 'category';
  static final List<String> _primaryKeyList = ['id'];
  static final String _whereStr = 'id=?';
}

//endregion CategoryManager
// region Todo
class Todo extends TableBase {
  Todo({this.id, this.userId, this.title, this.completed, this.dateCreated}) {
    _setDefaultValues();
  }
  Todo.withFields(
      this.id, this.userId, this.title, this.completed, this.dateCreated) {
    _setDefaultValues();
  }
  Todo.withId(
      this.id, this.userId, this.title, this.completed, this.dateCreated) {
    _setDefaultValues();
  }
  // fromMap v2.0
  Todo.fromMap(Map<String, dynamic> o, {bool setDefaultValues = true}) {
    if (setDefaultValues) {
      _setDefaultValues();
    }
    id = int.tryParse(o['id'].toString());
    if (o['userId'] != null) {
      userId = int.tryParse(o['userId'].toString());
    }
    if (o['title'] != null) {
      title = o['title'].toString();
    }
    if (o['completed'] != null) {
      completed = o['completed'].toString() == '1' ||
          o['completed'].toString() == 'true';
    }
    if (o['dateCreated'] != null) {
      dateCreated = int.tryParse(o['dateCreated'].toString()) != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(o['dateCreated'].toString())!)
          : DateTime.tryParse(o['dateCreated'].toString());
    }

    isSaved = true;
  }
  // FIELDS (Todo)
  int? id;
  int? userId;
  String? title;
  bool? completed;
  DateTime? dateCreated;
  bool? isSaved;
  BoolResult? saveResult;
  // end FIELDS (Todo)

  static const bool _softDeleteActivated = false;
  TodoManager? __mnTodo;

  TodoManager get _mnTodo {
    return __mnTodo = __mnTodo ?? TodoManager();
  }

  // METHODS
  Map<String, dynamic> toMap(
      {bool forQuery = false, bool forJson = false, bool forView = false}) {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    if (userId != null) {
      map['userId'] = userId;
    }

    if (title != null) {
      map['title'] = title;
    }

    if (completed != null) {
      map['completed'] = forQuery ? (completed! ? 1 : 0) : completed;
    }

    if (dateCreated != null) {
      map['dateCreated'] = forJson
          ? dateCreated!.toString()
          : forQuery
              ? dateCreated!.millisecondsSinceEpoch
              : dateCreated;
    }

    return map;
  }

  Future<Map<String, dynamic>> toMapWithChildren(
      [bool forQuery = false,
      bool forJson = false,
      bool forView = false]) async {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    if (userId != null) {
      map['userId'] = userId;
    }

    if (title != null) {
      map['title'] = title;
    }

    if (completed != null) {
      map['completed'] = forQuery ? (completed! ? 1 : 0) : completed;
    }

    if (dateCreated != null) {
      map['dateCreated'] = forJson
          ? dateCreated!.toString()
          : forQuery
              ? dateCreated!.millisecondsSinceEpoch
              : dateCreated;
    }

    return map;
  }

  /// This method returns Json String [Todo]
  String toJson() {
    return json.encode(toMap(forJson: true));
  }

  /// This method returns Json String [Todo]
  Future<String> toJsonWithChilds() async {
    return json.encode(await toMapWithChildren(false, true));
  }

  List<dynamic> toArgs() {
    return [
      id,
      userId,
      title,
      completed,
      dateCreated != null ? dateCreated!.millisecondsSinceEpoch : null
    ];
  }

  List<dynamic> toArgsWithIds() {
    return [
      id,
      userId,
      title,
      completed,
      dateCreated != null ? dateCreated!.millisecondsSinceEpoch : null
    ];
  }

  static Future<List<Todo>?> fromWeb({Map<String, String>? headers}) async {
    final objList = await fromWebUrl(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        headers: headers);
    return objList;
  }

  Future<http.Response> post({Map<String, String>? headers}) async {
    final res = await postUrl(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        headers: headers);
    return res;
  }

  static Future<List<Todo>?> fromWebUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      return await fromJson(response.body);
    } catch (e) {
      print('SQFENTITY ERROR Todo.fromWebUrl: ErrorMessage: ${e.toString()}');
      return null;
    }
  }

  Future<http.Response> postUrl(Uri uri, {Map<String, String>? headers}) {
    return http.post(uri, headers: headers, body: toJson());
  }

  static Future<List<Todo>> fromJson(String jsonBody) async {
    final Iterable list = await json.decode(jsonBody) as Iterable;
    var objList = <Todo>[];
    try {
      objList = list
          .map((todo) => Todo.fromMap(todo as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('SQFENTITY ERROR Todo.fromJson: ErrorMessage: ${e.toString()}');
    }
    return objList;
  }

  static Future<List<Todo>> fromMapList(List<dynamic> data,
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields,
      bool setDefaultValues = true}) async {
    final List<Todo> objList = <Todo>[];
    loadedFields = loadedFields ?? [];
    for (final map in data) {
      final obj = Todo.fromMap(map as Map<String, dynamic>,
          setDefaultValues: setDefaultValues);

      objList.add(obj);
    }
    return objList;
  }

  /// returns Todo by ID if exist, otherwise returns null
  ///
  /// Primary Keys: int? id
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: getById(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: getById(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>returns Todo if exist, otherwise returns null
  Future<Todo?> getById(int? id,
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    if (id == null) {
      return null;
    }
    Todo? obj;
    final data = await _mnTodo.getById([id]);
    if (data.length != 0) {
      obj = Todo.fromMap(data[0] as Map<String, dynamic>);
    } else {
      obj = null;
    }
    return obj;
  }

  /// Saves the (Todo) object. If the id field is null, saves as a new record and returns new id, if id is not null then updates record
  /// ignoreBatch = true as a default. Set ignoreBatch to false if you run more than one save() operation those are between batchStart and batchCommit
  /// <returns>Returns id
  Future<int?> save({bool ignoreBatch = true}) async {
    if (id == null || id == 0 || !isSaved!) {
      await _mnTodo.insert(this, ignoreBatch);
      if (saveResult!.success) {
        isSaved = true;
      }
    } else {
      // id= await _upsert(); // removed in sqfentity_gen 1.3.0+6
      await _mnTodo.update(this);
    }

    return id;
  }

  /// Saves the (Todo) object. If the id field is null, saves as a new record and returns new id, if id is not null then updates record
  ///
  /// ignoreBatch = true as a default. Set ignoreBatch to false if you run more than one save() operation those are between batchStart and batchCommit
  ///
  /// <returns>Returns id
  Future<int?> saveOrThrow({bool ignoreBatch = true}) async {
    if (id == null || id == 0 || !isSaved!) {
      await _mnTodo.insertOrThrow(this, ignoreBatch);
      if (saveResult != null && saveResult!.success) {
        isSaved = true;
      }
      isInsert = true;
    } else {
      // id= await _upsert(); // removed in sqfentity_gen 1.3.0+6
      await _mnTodo.updateOrThrow(this);
    }

    return id;
  }

  void rollbackId() {
    if (isInsert == true) {
      id = null;
    }
  }

  /// saveAll method saves the sent List<Todo> as a bulk in one transaction
  ///
  /// Returns a <List<BoolResult>>
  static Future<List<dynamic>> saveAll(List<Todo> todos) async {
    // final results = _mnTodo.saveAll('INSERT OR REPLACE INTO todos (id, userId, title, completed, dateCreated)  VALUES (?,?,?,?,?)',todos);
    // return results; removed in sqfentity_gen 1.3.0+6
    await MyDbModel().batchStart();
    for (final obj in todos) {
      await obj.save(ignoreBatch: false);
    }
    //    return MyDbModel().batchCommit();
    final result = await MyDbModel().batchCommit();

    return result!;
  }

  /// Updates if the record exists, otherwise adds a new row

  /// <returns>Returns id

  Future<int?> upsert() async {
    try {
      final result = await _mnTodo.rawInsert(
          'INSERT OR REPLACE INTO todos (id, userId, title, completed, dateCreated)  VALUES (?,?,?,?,?)',
          [
            id,
            userId,
            title,
            completed,
            dateCreated != null ? dateCreated!.millisecondsSinceEpoch : null
          ]);
      if (result! > 0) {
        saveResult = BoolResult(
            success: true, successMessage: 'Todo id=$id updated successfully');
      } else {
        saveResult = BoolResult(
            success: false, errorMessage: 'Todo id=$id did not update');
      }
      return id;
    } catch (e) {
      saveResult = BoolResult(
          success: false,
          errorMessage: 'Todo Save failed. Error: ${e.toString()}');
      return null;
    }
  }

  /// inserts or replaces the sent List<<Todo>> as a bulk in one transaction.
  ///
  /// upsertAll() method is faster then saveAll() method. upsertAll() should be used when you are sure that the primary key is greater than zero
  ///
  /// Returns a BoolCommitResult
  Future<BoolCommitResult> upsertAll(List<Todo> todos) async {
    final results = await _mnTodo.rawInsertAll(
        'INSERT OR REPLACE INTO todos (id, userId, title, completed, dateCreated)  VALUES (?,?,?,?,?)',
        todos);
    return results;
  }

  /// Deletes Todo

  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted

  Future<BoolResult> delete([bool hardDelete = false]) async {
    print('SQFENTITIY: delete Todo invoked (id=$id)');
    if (!_softDeleteActivated || hardDelete) {
      return _mnTodo
          .delete(QueryParams(whereString: 'id=?', whereArguments: [id]));
    } else {
      return _mnTodo.updateBatch(
          QueryParams(whereString: 'id=?', whereArguments: [id]),
          {'isDeleted': 1});
    }
  }

  TodoFilterBuilder select(
      {List<String>? columnsToSelect, bool? getIsDeleted}) {
    return TodoFilterBuilder(this)
      .._getIsDeleted = getIsDeleted == true
      ..qparams.selectColumns = columnsToSelect;
  }

  TodoFilterBuilder distinct(
      {List<String>? columnsToSelect, bool? getIsDeleted}) {
    return TodoFilterBuilder(this)
      .._getIsDeleted = getIsDeleted == true
      ..qparams.selectColumns = columnsToSelect
      ..qparams.distinct = true;
  }

  void _setDefaultValues() {
    isSaved = false;
    completed = completed ?? false;
    dateCreated = dateCreated ?? DateTime.now();
  }
  // END METHODS
  // BEGIN CUSTOM CODE
  /*
      you can define customCode property of your SqfEntityTable constant. For example:
      const tablePerson = SqfEntityTable(
      tableName: 'person',
      primaryKeyName: 'id',
      primaryKeyType: PrimaryKeyType.integer_auto_incremental,
      fields: [
        SqfEntityField('firstName', DbType.text),
        SqfEntityField('lastName', DbType.text),
      ],
      customCode: '''
       String fullName()
       { 
         return '$firstName $lastName';
       }
      ''');
     */
  // END CUSTOM CODE
}
// endregion todo

// region TodoField
class TodoField extends SearchCriteria {
  TodoField(this.todoFB);
  // { param = DbParameter(); }
  DbParameter param = DbParameter();
  String _waitingNot = '';
  TodoFilterBuilder todoFB;

  TodoField get not {
    _waitingNot = ' NOT ';
    return this;
  }

  TodoFilterBuilder equals(dynamic pValue) {
    param.expression = '=';
    todoFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, todoFB.parameters, param, SqlSyntax.EQuals,
            todoFB._addedBlocks)
        : setCriteria(pValue, todoFB.parameters, param, SqlSyntax.NotEQuals,
            todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder equalsOrNull(dynamic pValue) {
    param.expression = '=';
    todoFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, todoFB.parameters, param, SqlSyntax.EQualsOrNull,
            todoFB._addedBlocks)
        : setCriteria(pValue, todoFB.parameters, param,
            SqlSyntax.NotEQualsOrNull, todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder isNull() {
    todoFB._addedBlocks = setCriteria(
        0,
        todoFB.parameters,
        param,
        SqlSyntax.IsNULL.replaceAll(SqlSyntax.notKeyword, _waitingNot),
        todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder contains(dynamic pValue) {
    if (pValue != null) {
      todoFB._addedBlocks = setCriteria(
          '%${pValue.toString()}%',
          todoFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          todoFB._addedBlocks);
      _waitingNot = '';
      todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
          todoFB._addedBlocks.retVal;
    }
    return todoFB;
  }

  TodoFilterBuilder startsWith(dynamic pValue) {
    if (pValue != null) {
      todoFB._addedBlocks = setCriteria(
          '${pValue.toString()}%',
          todoFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          todoFB._addedBlocks);
      _waitingNot = '';
      todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
          todoFB._addedBlocks.retVal;
      todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
          todoFB._addedBlocks.retVal;
    }
    return todoFB;
  }

  TodoFilterBuilder endsWith(dynamic pValue) {
    if (pValue != null) {
      todoFB._addedBlocks = setCriteria(
          '%${pValue.toString()}',
          todoFB.parameters,
          param,
          SqlSyntax.Contains.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          todoFB._addedBlocks);
      _waitingNot = '';
      todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
          todoFB._addedBlocks.retVal;
    }
    return todoFB;
  }

  TodoFilterBuilder between(dynamic pFirst, dynamic pLast) {
    if (pFirst != null && pLast != null) {
      todoFB._addedBlocks = setCriteria(
          pFirst,
          todoFB.parameters,
          param,
          SqlSyntax.Between.replaceAll(SqlSyntax.notKeyword, _waitingNot),
          todoFB._addedBlocks,
          pLast);
    } else if (pFirst != null) {
      if (_waitingNot != '') {
        todoFB._addedBlocks = setCriteria(pFirst, todoFB.parameters, param,
            SqlSyntax.LessThan, todoFB._addedBlocks);
      } else {
        todoFB._addedBlocks = setCriteria(pFirst, todoFB.parameters, param,
            SqlSyntax.GreaterThanOrEquals, todoFB._addedBlocks);
      }
    } else if (pLast != null) {
      if (_waitingNot != '') {
        todoFB._addedBlocks = setCriteria(pLast, todoFB.parameters, param,
            SqlSyntax.GreaterThan, todoFB._addedBlocks);
      } else {
        todoFB._addedBlocks = setCriteria(pLast, todoFB.parameters, param,
            SqlSyntax.LessThanOrEquals, todoFB._addedBlocks);
      }
    }
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder greaterThan(dynamic pValue) {
    param.expression = '>';
    todoFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, todoFB.parameters, param, SqlSyntax.GreaterThan,
            todoFB._addedBlocks)
        : setCriteria(pValue, todoFB.parameters, param,
            SqlSyntax.LessThanOrEquals, todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder lessThan(dynamic pValue) {
    param.expression = '<';
    todoFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, todoFB.parameters, param, SqlSyntax.LessThan,
            todoFB._addedBlocks)
        : setCriteria(pValue, todoFB.parameters, param,
            SqlSyntax.GreaterThanOrEquals, todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder greaterThanOrEquals(dynamic pValue) {
    param.expression = '>=';
    todoFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, todoFB.parameters, param,
            SqlSyntax.GreaterThanOrEquals, todoFB._addedBlocks)
        : setCriteria(pValue, todoFB.parameters, param, SqlSyntax.LessThan,
            todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder lessThanOrEquals(dynamic pValue) {
    param.expression = '<=';
    todoFB._addedBlocks = _waitingNot == ''
        ? setCriteria(pValue, todoFB.parameters, param,
            SqlSyntax.LessThanOrEquals, todoFB._addedBlocks)
        : setCriteria(pValue, todoFB.parameters, param, SqlSyntax.GreaterThan,
            todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }

  TodoFilterBuilder inValues(dynamic pValue) {
    todoFB._addedBlocks = setCriteria(
        pValue,
        todoFB.parameters,
        param,
        SqlSyntax.IN.replaceAll(SqlSyntax.notKeyword, _waitingNot),
        todoFB._addedBlocks);
    _waitingNot = '';
    todoFB._addedBlocks.needEndBlock![todoFB._blockIndex] =
        todoFB._addedBlocks.retVal;
    return todoFB;
  }
}
// endregion TodoField

// region TodoFilterBuilder
class TodoFilterBuilder extends SearchCriteria {
  TodoFilterBuilder(Todo obj) {
    whereString = '';
    groupByList = <String>[];
    _addedBlocks.needEndBlock!.add(false);
    _addedBlocks.waitingStartBlock!.add(false);
    _obj = obj;
  }
  AddedBlocks _addedBlocks = AddedBlocks(<bool>[], <bool>[]);
  int _blockIndex = 0;
  List<DbParameter> parameters = <DbParameter>[];
  List<String> orderByList = <String>[];
  Todo? _obj;
  QueryParams qparams = QueryParams();
  int _pagesize = 0;
  int _page = 0;

  /// put the sql keyword 'AND'
  TodoFilterBuilder get and {
    if (parameters.isNotEmpty) {
      parameters[parameters.length - 1].wOperator = ' AND ';
    }
    return this;
  }

  /// put the sql keyword 'OR'
  TodoFilterBuilder get or {
    if (parameters.isNotEmpty) {
      parameters[parameters.length - 1].wOperator = ' OR ';
    }
    return this;
  }

  /// open parentheses
  TodoFilterBuilder get startBlock {
    _addedBlocks.waitingStartBlock!.add(true);
    _addedBlocks.needEndBlock!.add(false);
    _blockIndex++;
    if (_blockIndex > 1) {
      _addedBlocks.needEndBlock![_blockIndex - 1] = true;
    }
    return this;
  }

  /// String whereCriteria, write raw query without 'where' keyword. Like this: 'field1 like 'test%' and field2 = 3'
  TodoFilterBuilder where(String? whereCriteria, {dynamic parameterValue}) {
    if (whereCriteria != null && whereCriteria != '') {
      final DbParameter param = DbParameter(
          columnName: parameterValue == null ? null : '',
          hasParameter: parameterValue != null);
      _addedBlocks = setCriteria(parameterValue ?? 0, parameters, param,
          '($whereCriteria)', _addedBlocks);
      _addedBlocks.needEndBlock![_blockIndex] = _addedBlocks.retVal;
    }
    return this;
  }

  /// page = page number,
  ///
  /// pagesize = row(s) per page
  TodoFilterBuilder page(int page, int pagesize) {
    if (page > 0) {
      _page = page;
    }
    if (pagesize > 0) {
      _pagesize = pagesize;
    }
    return this;
  }

  /// int count = LIMIT
  TodoFilterBuilder top(int count) {
    if (count > 0) {
      _pagesize = count;
    }
    return this;
  }

  /// close parentheses
  TodoFilterBuilder get endBlock {
    if (_addedBlocks.needEndBlock![_blockIndex]) {
      parameters[parameters.length - 1].whereString += ' ) ';
    }
    _addedBlocks.needEndBlock!.removeAt(_blockIndex);
    _addedBlocks.waitingStartBlock!.removeAt(_blockIndex);
    _blockIndex--;
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='name, date'
  ///
  /// Example 2: argFields = ['name', 'date']
  TodoFilterBuilder orderBy(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        orderByList.add(argFields);
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            orderByList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='field1, field2'
  ///
  /// Example 2: argFields = ['field1', 'field2']
  TodoFilterBuilder orderByDesc(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        orderByList.add('$argFields desc ');
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            orderByList.add(' $s desc ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='field1, field2'
  ///
  /// Example 2: argFields = ['field1', 'field2']
  TodoFilterBuilder groupBy(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        groupByList.add(' $argFields ');
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            groupByList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  /// argFields might be String or List<String>.
  ///
  /// Example 1: argFields='name, date'
  ///
  /// Example 2: argFields = ['name', 'date']
  TodoFilterBuilder having(dynamic argFields) {
    if (argFields != null) {
      if (argFields is String) {
        havingList.add(argFields);
      } else {
        for (String? s in argFields as List<String?>) {
          if (s!.isNotEmpty) {
            havingList.add(' $s ');
          }
        }
      }
    }
    return this;
  }

  TodoField setField(TodoField? field, String colName, DbType dbtype) {
    return TodoField(this)
      ..param = DbParameter(
          dbType: dbtype,
          columnName: colName,
          wStartBlock: _addedBlocks.waitingStartBlock![_blockIndex]);
  }

  TodoField? _id;
  TodoField get id {
    return _id = setField(_id, 'id', DbType.integer);
  }

  TodoField? _userId;
  TodoField get userId {
    return _userId = setField(_userId, 'userId', DbType.integer);
  }

  TodoField? _title;
  TodoField get title {
    return _title = setField(_title, 'title', DbType.text);
  }

  TodoField? _completed;
  TodoField get completed {
    return _completed = setField(_completed, 'completed', DbType.bool);
  }

  TodoField? _dateCreated;
  TodoField get dateCreated {
    return _dateCreated =
        setField(_dateCreated, 'dateCreated', DbType.datetime);
  }

  bool _getIsDeleted = false;

  void _buildParameters() {
    if (_page > 0 && _pagesize > 0) {
      qparams
        ..limit = _pagesize
        ..offset = (_page - 1) * _pagesize;
    } else {
      qparams
        ..limit = _pagesize
        ..offset = _page;
    }
    for (DbParameter param in parameters) {
      if (param.columnName != null) {
        if (param.value is List && !param.hasParameter) {
          param.value = param.dbType == DbType.text || param.value[0] is String
              ? '\'${param.value.join('\',\'')}\''
              : param.value.join(',');
          whereString += param.whereString
              .replaceAll('{field}', param.columnName!)
              .replaceAll('?', param.value.toString());
          param.value = null;
        } else {
          if (param.value is Map<String, dynamic> &&
              param.value['sql'] != null) {
            param
              ..whereString = param.whereString
                  .replaceAll('?', param.value['sql'].toString())
              ..dbType = DbType.integer
              ..value = param.value['args'];
          }
          whereString +=
              param.whereString.replaceAll('{field}', param.columnName!);
        }
        if (!param.whereString.contains('?')) {
        } else {
          switch (param.dbType) {
            case DbType.bool:
              param.value = param.value == null
                  ? null
                  : param.value == true
                      ? 1
                      : 0;
              param.value2 = param.value2 == null
                  ? null
                  : param.value2 == true
                      ? 1
                      : 0;
              break;
            case DbType.date:
            case DbType.datetime:
            case DbType.datetimeUtc:
              param.value = param.value == null
                  ? null
                  : (param.value as DateTime).millisecondsSinceEpoch;
              param.value2 = param.value2 == null
                  ? null
                  : (param.value2 as DateTime).millisecondsSinceEpoch;
              break;
            default:
          }
          if (param.value != null) {
            if (param.value is List) {
              for (var p in param.value) {
                whereArguments.add(p);
              }
            } else {
              whereArguments.add(param.value);
            }
          }
          if (param.value2 != null) {
            whereArguments.add(param.value2);
          }
        }
      } else {
        whereString += param.whereString;
      }
    }
    if (Todo._softDeleteActivated) {
      if (whereString != '') {
        whereString =
            '${!_getIsDeleted ? 'ifnull(isDeleted,0)=0 AND' : ''} ($whereString)';
      } else if (!_getIsDeleted) {
        whereString = 'ifnull(isDeleted,0)=0';
      }
    }

    if (whereString != '') {
      qparams.whereString = whereString;
    }
    qparams
      ..whereArguments = whereArguments
      ..groupBy = groupByList.join(',')
      ..orderBy = orderByList.join(',')
      ..having = havingList.join(',');
  }

  /// Deletes List<Todo> bulk by query
  ///
  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted
  Future<BoolResult> delete([bool hardDelete = false]) async {
    _buildParameters();
    var r = BoolResult(success: false);

    if (Todo._softDeleteActivated && !hardDelete) {
      r = await _obj!._mnTodo.updateBatch(qparams, {'isDeleted': 1});
    } else {
      r = await _obj!._mnTodo.delete(qparams);
    }
    return r;
  }

  /// using:
  ///
  /// update({'fieldName': Value})
  ///
  /// fieldName must be String. Value is dynamic, it can be any of the (int, bool, String.. )
  Future<BoolResult> update(Map<String, dynamic> values) {
    _buildParameters();
    if (qparams.limit! > 0 || qparams.offset! > 0) {
      qparams.whereString =
          'id IN (SELECT id from todos ${qparams.whereString!.isNotEmpty ? 'WHERE ${qparams.whereString}' : ''}${qparams.limit! > 0 ? ' LIMIT ${qparams.limit}' : ''}${qparams.offset! > 0 ? ' OFFSET ${qparams.offset}' : ''})';
    }
    return _obj!._mnTodo.updateBatch(qparams, values);
  }

  /// This method always returns Todo Obj if exist, otherwise returns null
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: toSingle(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: toSingle(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>List<Todo>
  Future<Todo?> toSingle(
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    _pagesize = 1;
    _buildParameters();
    final objFuture = _obj!._mnTodo.toList(qparams);
    final data = await objFuture;
    Todo? obj;
    if (data.isNotEmpty) {
      obj = Todo.fromMap(data[0] as Map<String, dynamic>);
    } else {
      obj = null;
    }
    return obj;
  }

  /// This method returns int. [Todo]
  ///
  /// <returns>int
  Future<int> toCount([VoidCallback Function(int c)? todoCount]) async {
    _buildParameters();
    qparams.selectColumns = ['COUNT(1) AS CNT'];
    final todosFuture = await _obj!._mnTodo.toList(qparams);
    final int count = todosFuture[0]['CNT'] as int;
    if (todoCount != null) {
      todoCount(count);
    }
    return count;
  }

  /// This method returns List<Todo> [Todo]
  ///
  /// bool preload: if true, loads all related child objects (Set preload to true if you want to load all fields related to child or parent)
  ///
  /// ex: toList(preload:true) -> Loads all related objects
  ///
  /// List<String> preloadFields: specify the fields you want to preload (preload parameter's value should also be "true")
  ///
  /// ex: toList(preload:true, preloadFields:['plField1','plField2'... etc])  -> Loads only certain fields what you specified
  ///
  /// bool loadParents: if true, loads all parent objects until the object has no parent

  ///
  /// <returns>List<Todo>
  Future<List<Todo>> toList(
      {bool preload = false,
      List<String>? preloadFields,
      bool loadParents = false,
      List<String>? loadedFields}) async {
    final data = await toMapList();
    final List<Todo> todosData = await Todo.fromMapList(data,
        preload: preload,
        preloadFields: preloadFields,
        loadParents: loadParents,
        loadedFields: loadedFields,
        setDefaultValues: qparams.selectColumns == null);
    return todosData;
  }

  /// This method returns Json String [Todo]
  Future<String> toJson() async {
    final list = <dynamic>[];
    final data = await toList();
    for (var o in data) {
      list.add(o.toMap(forJson: true));
    }
    return json.encode(list);
  }

  /// This method returns Json String. [Todo]
  Future<String> toJsonWithChilds() async {
    final list = <dynamic>[];
    final data = await toList();
    for (var o in data) {
      list.add(await o.toMapWithChildren(false, true));
    }
    return json.encode(list);
  }

  /// This method returns List<dynamic>. [Todo]
  ///
  /// <returns>List<dynamic>
  Future<List<dynamic>> toMapList() async {
    _buildParameters();
    return await _obj!._mnTodo.toList(qparams);
  }

  /// Returns List<DropdownMenuItem<Todo>>
  Future<List<DropdownMenuItem<Todo>>> toDropDownMenu(String displayTextColumn,
      [VoidCallback Function(List<DropdownMenuItem<Todo>> o)?
          dropDownMenu]) async {
    _buildParameters();
    final todosFuture = _obj!._mnTodo.toList(qparams);

    final data = await todosFuture;
    final int count = data.length;
    final List<DropdownMenuItem<Todo>> items = []..add(DropdownMenuItem(
        value: Todo(),
        child: Text('Select Todo'),
      ));
    for (int i = 0; i < count; i++) {
      items.add(
        DropdownMenuItem(
          value: Todo.fromMap(data[i] as Map<String, dynamic>),
          child: Text(data[i][displayTextColumn].toString()),
        ),
      );
    }
    if (dropDownMenu != null) {
      dropDownMenu(items);
    }
    return items;
  }

  /// Returns List<DropdownMenuItem<int>>
  Future<List<DropdownMenuItem<int>>> toDropDownMenuInt(
      String displayTextColumn,
      [VoidCallback Function(List<DropdownMenuItem<int>> o)?
          dropDownMenu]) async {
    _buildParameters();
    qparams.selectColumns = ['id', displayTextColumn];
    final todosFuture = _obj!._mnTodo.toList(qparams);

    final data = await todosFuture;
    final int count = data.length;
    final List<DropdownMenuItem<int>> items = []..add(DropdownMenuItem(
        value: 0,
        child: Text('Select Todo'),
      ));
    for (int i = 0; i < count; i++) {
      items.add(
        DropdownMenuItem(
          value: data[i]['id'] as int,
          child: Text(data[i][displayTextColumn].toString()),
        ),
      );
    }
    if (dropDownMenu != null) {
      dropDownMenu(items);
    }
    return items;
  }

  /// This method returns Primary Key List SQL and Parameters retVal = Map<String,dynamic>. [Todo]
  ///
  /// retVal['sql'] = SQL statement string, retVal['args'] = whereArguments List<dynamic>;
  ///
  /// <returns>List<String>
  Map<String, dynamic> toListPrimaryKeySQL([bool buildParameters = true]) {
    final Map<String, dynamic> _retVal = <String, dynamic>{};
    if (buildParameters) {
      _buildParameters();
    }
    _retVal['sql'] = 'SELECT `id` FROM todos WHERE ${qparams.whereString}';
    _retVal['args'] = qparams.whereArguments;
    return _retVal;
  }

  /// This method returns Primary Key List<int>.
  /// <returns>List<int>
  Future<List<int>> toListPrimaryKey([bool buildParameters = true]) async {
    if (buildParameters) {
      _buildParameters();
    }
    final List<int> idData = <int>[];
    qparams.selectColumns = ['id'];
    final idFuture = await _obj!._mnTodo.toList(qparams);

    final int count = idFuture.length;
    for (int i = 0; i < count; i++) {
      idData.add(idFuture[i]['id'] as int);
    }
    return idData;
  }

  /// Returns List<dynamic> for selected columns. Use this method for 'groupBy' with min,max,avg..  [Todo]
  ///
  /// Sample usage: (see EXAMPLE 4.2 at https://github.com/hhtokpinar/sqfEntity#group-by)
  Future<List<dynamic>> toListObject() async {
    _buildParameters();

    final objectFuture = _obj!._mnTodo.toList(qparams);

    final List<dynamic> objectsData = <dynamic>[];
    final data = await objectFuture;
    final int count = data.length;
    for (int i = 0; i < count; i++) {
      objectsData.add(data[i]);
    }
    return objectsData;
  }

  /// Returns List<String> for selected first column
  ///
  /// Sample usage: await Todo.select(columnsToSelect: ['columnName']).toListString()
  Future<List<String>> toListString(
      [VoidCallback Function(List<String> o)? listString]) async {
    _buildParameters();

    final objectFuture = _obj!._mnTodo.toList(qparams);

    final List<String> objectsData = <String>[];
    final data = await objectFuture;
    final int count = data.length;
    for (int i = 0; i < count; i++) {
      objectsData.add(data[i][qparams.selectColumns![0]].toString());
    }
    if (listString != null) {
      listString(objectsData);
    }
    return objectsData;
  }
}
// endregion TodoFilterBuilder

// region TodoFields
class TodoFields {
  static TableField? _fId;
  static TableField get id {
    return _fId = _fId ?? SqlSyntax.setField(_fId, 'id', DbType.integer);
  }

  static TableField? _fUserId;
  static TableField get userId {
    return _fUserId =
        _fUserId ?? SqlSyntax.setField(_fUserId, 'userId', DbType.integer);
  }

  static TableField? _fTitle;
  static TableField get title {
    return _fTitle =
        _fTitle ?? SqlSyntax.setField(_fTitle, 'title', DbType.text);
  }

  static TableField? _fCompleted;
  static TableField get completed {
    return _fCompleted = _fCompleted ??
        SqlSyntax.setField(_fCompleted, 'completed', DbType.bool);
  }

  static TableField? _fDateCreated;
  static TableField get dateCreated {
    return _fDateCreated = _fDateCreated ??
        SqlSyntax.setField(_fDateCreated, 'dateCreated', DbType.datetime);
  }
}
// endregion TodoFields

//region TodoManager
class TodoManager extends SqfEntityProvider {
  TodoManager()
      : super(MyDbModel(),
            tableName: _tableName,
            primaryKeyList: _primaryKeyList,
            whereStr: _whereStr);
  static final String _tableName = 'todos';
  static final List<String> _primaryKeyList = ['id'];
  static final String _whereStr = 'id=?';
}

//endregion TodoManager
/// Region SEQUENCE IdentitySequence
class IdentitySequence {
  /// Assigns a new value when it is triggered and returns the new value
  /// returns Future<int>
  Future<int> nextVal([VoidCallback Function(int o)? nextval]) async {
    final val = await MyDbModelSequenceManager()
        .sequence(SequenceIdentitySequence.getInstance, true);
    if (nextval != null) {
      nextval(val);
    }
    return val;
  }

  /// Get the current value
  /// returns Future<int>
  Future<int> currentVal([VoidCallback Function(int o)? currentval]) async {
    final val = await MyDbModelSequenceManager()
        .sequence(SequenceIdentitySequence.getInstance, false);
    if (currentval != null) {
      currentval(val);
    }
    return val;
  }

  /// Reset sequence to start value
  /// returns start value
  Future<int> reset([VoidCallback Function(int o)? currentval]) async {
    final val = await MyDbModelSequenceManager()
        .sequence(SequenceIdentitySequence.getInstance, false, reset: true);
    if (currentval != null) {
      currentval(val);
    }
    return val;
  }
}

/// End Region SEQUENCE IdentitySequence

class MyDbModelSequenceManager extends SqfEntityProvider {
  MyDbModelSequenceManager() : super(MyDbModel());
}
// END OF ENTITIES
