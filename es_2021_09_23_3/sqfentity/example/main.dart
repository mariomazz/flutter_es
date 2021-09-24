import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

import 'model/model.dart';

const SqfEntityTable tableCategory = SqfEntityTable(
    tableName: 'category',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('isActive', DbType.bool, defaultValue: true),
    ]);

const SqfEntityTable tableProduct = SqfEntityTable(
    tableName: 'product',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('description', DbType.text),
      SqfEntityField('price', DbType.real, defaultValue: 0),
      SqfEntityField('isActive', DbType.bool, defaultValue: true),
      SqfEntityFieldRelationship(
          parentTable: tableCategory,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: '0'),
      SqfEntityField('rownum', DbType.integer, sequencedBy: seqIdentity),
      SqfEntityField('imageUrl', DbType.text)
    ]);

const SqfEntityTable tableTodo = SqfEntityTable(
    tableName: 'todos',
    primaryKeyName: 'id',
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.integer_unique,
    defaultJsonUrl: 'https://jsonplaceholder.typicode.com/todos',
    fields: [
      SqfEntityField('userId', DbType.integer),
      SqfEntityField('title', DbType.text),
      SqfEntityField('completed', DbType.bool, defaultValue: false)
    ]);

const SqfEntitySequence seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
  maxValue: 10000,
);

@SqfEntityBuilder(myDbModel)
const SqfEntityModel myDbModel = SqfEntityModel(
    modelName: null,
    databaseName: 'sampleORM.db',
    databaseTables: [tableCategory, tableProduct, tableTodo],
    formTables: [tableProduct, tableCategory, tableTodo],
    sequences: [seqIdentity],
    bundledDatabasePath: null);

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await runSamples();
}

Future<bool> runSamples() async {
  await addSomeProducts();

  printCategories(false);

  await samples1();

  await samples2();

  await samples3();

  await samples4();

  await samples5();

  await samples6();

  await samples7();

  await samples8();

  await samples9();

  await samples10();

  await samples11();

  await createModelFromDatabaseSample();

  return true;
}

Future<void> printListDynamic(SqfEntityProvider model, String pSql) async {
  final list = await model.execDataTable(pSql);
  printList(list);
}

void printList(List<dynamic> list, {bool isMap = false, String? title}) {
  print('PRINTLIST--------------$title---------------lenght: ${list.length}');
  for (final o in list) {
    if (isMap) {
      print(o.toMap());
    } else {
      print(o.toString());
    }
  }
}

Future<void> printCategories(bool getIsDeleted) async {
  final categoryList =
      await Category().select(getIsDeleted: getIsDeleted).toList();
  print('LISTING CATEGORIES -> Category().select().toList()');
  print('${categoryList.length} matches found:');
  for (int i = 0; i < categoryList.length; i++) {
    print(categoryList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');
}

class BundledDbModel extends SqfEntityModelProvider {}

Future<String> createModelFromDatabaseSample() async {
  final bundledDbModel = await convertDatabaseToModelBase(BundledDbModel()
    ..databaseName = 'chinook.db'
    ..bundledDatabasePath = 'assets/chinook.sqlite');

  final String modelConstString =
      SqfEntityConverter(bundledDbModel).createConstDatabase();

  await Clipboard.setData(ClipboardData(text: modelConstString));

  print('''Your ${bundledDbModel.databaseName} 
      were created succesfuly and set to the Clipboard. 

      STEP 1:
      Open model.dart file in lib/model folder and paste models after following line
      part 'model.g.dart';

      STEP 2:
      Go Terminal Window and run command below
      flutter pub run build_runner build --delete-conflicting-outputs
      Your Entity models will be created in lib/model/model.g.dart''');

  return modelConstString;
}

Future<String> createSqfEntityModelString([bool setClipboard = true]) async {
  final model = SqfEntityModelConverter(myDbModel).toModelBase();
  final strModel = StringBuffer()
    ..writeln('part of \'model.dart\';')
    ..writeln(SqfEntityConverter(model).createModelDatabase())
    ..writeln(SqfEntityConverter(model).createEntites());

  if (setClipboard) {
    await Clipboard.setData(ClipboardData(text: strModel.toString()));
  }

  return strModel.toString();
}

Future<void> printProducts() async {
  final productList = await Product().select().toList();
  print(
      'EXAMPLE 1.1: SELECT ALL ROWS WITHOUT FILTER ex: SELECT * FROM PRODUCTS \n -> Product().select().toList()');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');
}

Future<void> samples1() async {
  await printProducts();

  var productList = await Product()
      .select()
      .orderBy('name')
      .orderByDesc('price')
      .orderBy('id')
      .toList();
  print(
      'EXAMPLE 1.2: ORDER BY FIELDS ex: SELECT * FROM PRODUCTS ORDER BY name, price DESC, id \n-> Product().select().orderBy(\'name\').orderByDesc(\'price\').orderBy(\'id\').toList()');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  print(
      'EXAMPLE 1.3: SELECT SPECIFIC FIELDS ex: SELECT name,price FROM PRODUCTS ORDER BY price DESC \n-> Product().select(columnsToSelect: [\'name\',\'price\']).orderByDesc(\'price\').toList()');

  productList = await Product()
      .select(columnsToSelect: ['name', 'price'])
      .orderByDesc('price')
      .toList();

  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------');
}

Future<void> samples2() async {
  var productList = await Product().select().isActive.equals(true).toList();
  print(
      'EXAMPLE 1.4: EQUALS ex: SELECT * FROM PRODUCTS WHERE isActive=1 \n->  Product().select().isActive.equals(true).toList()');

  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product().select().id.inValues([3, 6, 9]).toList();
  print(
      'EXAMPLE 1.5: WHERE field IN (VALUES) ex: SELECT * FROM PRODUCTS WHERE ID IN (3,6,9) \n -> Product().select().id.inValues([3,6,9]).toList()');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  final singleProduct = await Product()
      .select()
      .price
      .greaterThan(10000)
      .and
      .startBlock
      .description
      .contains('256')
      .or
      .description
      .startsWith('512')
      .endBlock
      .toSingle();
  print(
      'EXAMPLE 1.6: BRACKETS ex: SELECT TOP 1 * FROM PRODUCTS WHERE price>10000 AND (description LIKE \'%256%\' OR description LIKE \'512%\') \n -> Product().select().price.greaterThan(10000).and.startBlock.description.contains(\'256\').or.description.startsWith(\'512").endBlock.toSingle((product){ // TO DO })');
  print('Toplam ${(singleProduct != null ? '1' : '0')} sonuç listeleniyor:');
  if (singleProduct != null) {
    print(singleProduct.toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product()
      .select()
      .price
      .lessThanOrEquals(10000)
      .and
      .startBlock
      .description
      .contains('128')
      .or
      .description
      .endsWith('GB')
      .or
      .description
      .startsWith('128')
      .endBlock
      .toList();
  print(
      'EXAMPLE 1.7: BRACKETS 2 ex: SELECT name,price FROM PRODUCTS WHERE price <=10000 AND (description LIKE \'%128%\' OR description LIKE \'%GB\') \n -> Product().select(columnsToSelect:[\'name\',\'price\']).price.lessThanOrEquals(10000).and.startBlock.description.contains(\'128\').or.description.endsWith(\'GB\').endBlock.toList();');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product().select().id.not.equals(11).toList();
  print(
      'EXAMPLE 1.8: NOT EQUALS ex: SELECT * FROM PRODUCTS WHERE ID <> 11 \n -> Product().select().id.not.equals(11).toList();');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product()
      .select()
      .price
      .greaterThanOrEquals(10000)
      .and
      .price
      .lessThanOrEquals(13000)
      .toList();
  print(
      'EXAMPLE 1.9: GREATERTHEN OR EQUALS, LESSTHAN OR EQUALS ex: SELECT * FROM PRODUCTS WHERE price>=10000 AND price<=13000 \n -> Product().select().price.greaterThanOrEquals(10000).and.price.lessThanOrEquals(13000).toList();');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product()
      .select()
      .price
      .between(8000, 14000)
      .orderBy('price')
      .toList();
  print(
      'EXAMPLE 1.10: BETWEEN ex: SELECT * FROM PRODUCTS WHERE price BETWEEN 8000 AND 14000 \n -> Product().select().price.between(8000,14000).orderBy(\'price\').toList();');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product().select().id.not.greaterThan(5).toList();
  print(
      'EXAMPLE 1.11: \'NOT\' KEYWORD ex: SELECT * FROM PRODUCTS WHERE NOT id>5 \n -> Product().select().id.not.greaterThan(5).toList();');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product()
      .select()
      .where('id IN (3,6,9) OR price>?', parameterValue: 8000)
      .toList();
  print(
      'EXAMPLE 1.12: WRITING CUSTOM FILTER IN WHERE CLAUSE ex: SELECT * FROM PRODUCTS WHERE id IN (3,6,9) OR price>8000 \n -> Product().select().where(\'id IN (3,6,9) OR price>8000\').toList()');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  int minPrice;
  int maxPrice;
  String nameContains;
  String descriptionContains;

  minPrice = 8000;
  maxPrice = 10000;
  nameContains = '13';
  descriptionContains = 'SSD';

  productList = await Product()
      .select()
      .price
      .between(minPrice, maxPrice)
      .and
      .name
      .contains(nameContains)
      .and
      .description
      .contains(descriptionContains)
      .toList();
  print(
      'EXAMPLE 1.13: Product().select().price.between($minPrice, $maxPrice).and.name.contains(\'$nameContains\').and.description.contains(\'$descriptionContains\').toList()');
  print('${productList.length} matches found:');
  for (var prod in productList) {
    print(prod.toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product().select(getIsDeleted: true).toList();
  print(
      'EXAMPLE 1.14: EXAMPLE 1.13: Select products with deleted items\n -> Product().select(getIsDeleted: true).toList()');
  print('${productList.length} matches found:');

  for (var prod in productList) {
    print(prod.toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product()
      .select(getIsDeleted: true)
      .isDeleted
      .equals(true)
      .toList();
  print(
      'EXAMPLE 1.15: Select products only deleted items \n -> Product().select(getIsDeleted: true).isDeleted.equals(true).toList()');

  print('${productList.length} matches found:');
  for (var prod in productList) {
    print(prod.toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product()
      .select()
      .where(
          'datetime BETWEEN \'${DateTime(2020, 1, 1, 14)}\' AND \'${DateTime(2020, 1, 1, 14).millisecondsSinceEpoch}\'')
      .toList();
  print(
      'EXAMPLE 1.16: Select products between datetimes \n -> Product().select().datetime.between(DateTime(2020,1,1,14), DateTime(2020,1,5,15)).toList()');
  print('${productList.length} matches found:');
  for (var prod in productList) {
    print(prod.toMap());
  }
  print('---------------------------------------------------------------\n\n');
}

Future<void> samples3() async {
  var productList =
      await Product().select().orderByDesc('price').top(3).toList();
  print(
      'EXAMPLE 3.1: LIMITATION ex: SELECT TOP 3 * FROM PRODUCTS ORDER BY price DESC \n -> Product().select().orderByDesc(\'price\').top(3).toList()');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  productList = await Product().select().page(3, 5).toList();
  print(
      'EXAMPLE 3.2: SAMPLE PAGING ex: PRODUCTS in 3. page (5 items per page) \n -> Product().select().page(3,5).toList()');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');
}

Future<void> samples4() async {
  final productList = await Product()
      .distinct(columnsToSelect: ['name'])
      .price
      .greaterThan(3000)
      .toList();
  print(
      'EXAMPLE 4.1: DISTINCT ex: SELECT DISTINCT name FROM PRODUCTS WHERE price > 3000 \n -> Product().distinct(columnsToSelect:[\'name\').price.greaterThan(3000).toList();');
  print('${productList.length} matches found:');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------\n\n');

  final objectList = await Product()
      .select(columnsToSelect: [
        ProductFields.name.toString(),
        ProductFields.id.count('Count'),
        ProductFields.price.min('minPrice'),
        ProductFields.price.max('maxPrice'),
        ProductFields.price.avg('avgPrice'),
        ProductFields.price.sum('sumPrice'),
      ])
      .groupBy(ProductFields.name.toString())
      .toListObject();
  print(
      'EXAMPLE 4.2: GROUP BY WITH SCALAR OR AGGREGATE FUNCTIONS ex: SELECT name, COUNT(id) AS Count, MIN(price) AS minPrice, MAX(price) AS maxPrice, AVG(price) AS avgPrice,ProductFields.price.sum(\'sumPrice\') FROM PRODUCTS GROUP BY name \n-> Product().select(columnsToSelect: [ProductFields.name.toString(), ProductFields.id.count(\'Count\'), ProductFields.price.min(\'minPrice\'), ProductFields.price.max(\'maxPrice\'), ProductFields.price.avg(\'avgPrice\')).groupBy(ProductFields.name.toString()).toListObject()');
  print('${objectList.length} matches found:');
  for (int i = 0; i < objectList.length; i++) {
    print(objectList[i].toString());
  }
  print('---------------------------------------------------------------');
}

Future<void> samples5() async {
  var result =
      await Product().select().id.greaterThan(10).update({'isActive': 0});
  print(
      'EXAMPLE 5.1: Update multiple records with query \n -> Product().select().id.greaterThan(10).update({\'isActive\': 0});');
  print(result.toString());
  print('---------------------------------------------------------------\n\n');

  await Product().select().categoryId.equals(1).update({
    'imageUrl':
        'https://raw.githubusercontent.com/hhtokpinar/sqfEntity/master/example/assets/notebook.png'
  });
  await Product().select().categoryId.equals(2).update({
    'imageUrl':
        'https://raw.githubusercontent.com/hhtokpinar/sqfEntity/master/example/assets/ultrabook.png'
  });

  result =
      await Product().select().id.lessThanOrEquals(10).update({'isActive': 1});
  print(
      'EXAMPLE 5.2: uUpdate multiple records with query \n -> Product().select().id.lessThanOrEquals(10).update({\'isActive\': 1});');
  print(result.toString());
  print('---------------------------------------------------------------\n\n');

  final product2 = await Product().getById(15);
  if (product2 != null) {
    product2.description = '512GB SSD i7 (updated)';
    await product2.save();
    print(
        'EXAMPLE 5.3: id=15 Product item updated: ${product2.toMap().toString()}');
  } else {
    print('EXAMPLE 5.3: id=15 => product not found');
  }
  print('---------------------------------------------------------------\n\n');

  var productList = await Product().select().price.lessThan(1000).toList();
  double i = 0;
  for (var product in productList) {
    i = i + 10;
    product.price = i;
  }
  final results = await Product.saveAll(productList);
  productList = await Product().select().toList();
  print(
      'EXAMPLE 5.4: update some filtered products with saveAll method \n -> Product().saveAll(productList){});');

  print(' List<BoolResult> result of saveAll method is following:');

  for (var result in results) {
    print(result.toString());
  }
  print('---------------------------------------------------------------');

  print(
      'EXAMPLE 5.4: listing saved products (set price=i) with saveAll method;');
  for (int i = 0; i < productList.length; i++) {
    print(productList[i].toMap());
  }
  print('---------------------------------------------------------------');
}

Future<void> samples6() async {
  var result = await Product().select().id.equals(16).delete();
  print(
      'EXAMPLE 6.2: delete product by query filder \n -> Product().select().id.equals(16).delete();');
  print(result.toString());
  print('---------------------------------------------------------------\n\n');

  final product = await Product().getById(17);
  if (product != null) {
    result = await product.delete();
    print(
        'EXAMPLE 6.3: delete product if exist \n -> if (product != null) Product.delete();');
    if (result.success) {
      print('${result.successMessage}');
    } else {
      print('${result.errorMessage}');
    }
    print(
        '---------------------------------------------------------------\n\n');
  } else {
    print('id=15 => product not found');
    print(
        '---------------------------------------------------------------\n\n');
  }

  result = await Product().select().id.greaterThan(17).delete();
  print(
      'EXAMPLE 6.4: Delete many products by filter \n -> Product().select().id.greaterThan(17).delete()');
  if (result.success) {
    print('${result.successMessage}');
  } else {
    print('${result.errorMessage}');
  }
  print('---------------------------------------------------------------\n\n');

  result = await Product().select().id.greaterThan(17).recover();
  print(
      'EXAMPLE 6.6: Recover many products by filter \n -> Product().select().id.greaterThan(17).recover()');
  if (result.success) {
    print('${result.successMessage}');
  } else {
    print('${result.errorMessage}');
  }
  print('---------------------------------------------------------------\n\n');
}

Future<void> samples7() async {
  final product = await Product().getById(3);
  if (product != null) {
    final category = await product.getCategory();
    print(
        'EXAMPLE 7.1: goto Category Object from Product \n-> Product.getCategory(); ');

    print(
        'The category of \'${product.name}\' is: ${category == null ? 'null' : category.toMap()}');
  }
  final categoryList = await Category().select().toList();
  for (var category in categoryList) {
    final productList = await category.getProducts()!.toList();
    print(
        'EXAMPLE 7.2.${category.id}: Products of \'${category.name}\' listing \n-> category.getProducts((productList) {}); ');
    print('${productList.length} matches found:');
    for (int i = 0; i < productList.length; i++) {
      print(productList[i].toMap());
    }
    print('---------------------------------------------------------------');
    return;
  }
  return;
}

Future<void> samples8() async {
  List<Todo>? todosList = await Todo.fromWeb();
  if (todosList != null) {
    await Todo().upsertAll(todosList);

    todosList = await Todo().select().top(10).toList();
    print(
        'EXAMPLE 8.1: Fill List from web (JSON data) and upsertAll \n -> Todo.fromWeb((todosList) {}');
    print('${todosList.length.toString()} matches found\n');
    for (var todo in todosList) {
      print(todo.toMap());
    }
    print(
        '---------------------------------------------------------------\n\n');
  }
  todosList = await Todo.fromWebUrl(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  if (todosList != null) {
    final results = await Todo().upsertAll(todosList);
    print(
        'EXAMPLE 8.2: upsertAll result \n -> final results = await Todo().upsertAll(todosList);');

    for (var res in results.commitResult!) {
      res = res;
    }
  }
  todosList = await Todo().select().top(10).toList();
  print(
      'EXAMPLE 8.2: Fill List from web with Url (JSON data) and upsertAll \n -> Todo.fromWebUrl(\'https://jsonplaceholder.typicode.com/todos\', (todosList) {}');
  print('${todosList.length.toString()} matches found\n');
  for (var todo in todosList) {
    print(todo.toMap());
  }
  print('---------------------------------------------------------------\n\n');
}

Future<void> samples9() async {
  final sql_91 = 'UPDATE product set isActive=1 where isActive=1';
  final result_91 = await MyDbModel().execSQL(sql_91);
  print(
      'EX.9.1 Execute custom SQL command on database\n -> final sql=\'$sql_91\';\n -> MyDbModel().execSQL(sql)  \n -> print result = ${result_91.toString()}');

  final sqlList = <String>[]
    ..add('UPDATE product set isActive=1 where isActive=1')
    ..add('UPDATE product set isActive=0 where isActive=0');

  final result_92 = await MyDbModel().execSQLList(sqlList);
  print(
      'EX.9.2 Execute custom SQL command List on database\n -> final sqlList=List<String>();\n -> MyDbModel().execSQLList(sqlList);  \n -> print result = ${result_92.toString()}');

  final sql_93 = 'SELECT name, price FROM product order by price desc LIMIT 5';
  final result_93 = await MyDbModel().execDataTable(sql_93);
  print(
      'EX.9.3 Execute custom SQL Query and get datatable -> returns List<Map<String,dynamic>> \n -> MyDbModel().execDataTable(\'$sql_93\');\n -> print result:');
  for (var item in result_93) {
    print(item.toString());
  }

  final sql_94 = 'SELECT name FROM product order by price desc';
  final result_94 = await MyDbModel().execScalar(sql_94);
  print(
      'EX.9.4 Execute custom SQL Query and get first col of first row -> returns dynamic \n -> MyDbModel().execScalar(\'$sql_94\');\n -> print result:');
  print(result_94.toString());
}

Future<void> samples10() async {
  print('EXAMPLE 10 SqfEntity Sequence SAMPLES-----------');

  final int currentVal = await IdentitySequence().currentVal();
  final int nextVal = await IdentitySequence().nextVal();
  final int nextVal2 = await IdentitySequence().nextVal();
  final int currentVal2 = await IdentitySequence().currentVal();

  print('Sample Code:\n');
  print('''
  final currentVal= await IdentitySequence().currentVal();
  result: currentVal = $currentVal
  final nextVal = await IdentitySequence().nextVal();
  result: nextVal = $nextVal
  final int nextVal2 = await IdentitySequence().nextVal();
  result: nextVal2 = $nextVal2
  final int currentVal2 = await IdentitySequence().currentVal();
  result: currentVal2 = $currentVal2
  ''');
}

Future<void> samples11() async {
  final product = await Product().select().toSingle();
  final jsonString = product!.toJson();

  print(
      'EXAMPLE 11.1 single object to Json\n product jsonString is: $jsonString');

  final jsonStringWithChilds = await Category().select().toJsonWithChilds();
  print(
      'EXAMPLE 11.2 object list with nested objects to Json\n categories jsonStringWithChilds is: $jsonStringWithChilds');
}

Future<void> addSomeProducts() async {
  await addCategories();
  final product = await Product().select().toSingle();
  if (product == null) {
    await addProducts();
  } else {
    print(
        'There is already products in the database.. addProduct will not run');
  }
  return;
}

Future<void> addCategories() async {
  final category = await Category().select().toSingle();
  if (category == null) {
    MyDbModel().batchStart();

    await Category(name: 'Notebooks', isActive: true).save(ignoreBatch: false);
    await Category(name: 'Ultrabooks', isActive: true).save();
  } else {
    print(
        'There is already categories in the database.. addCategories will not run');
  }
}

Future<bool> addProducts() async {
  final productList = await Product().select(getIsDeleted: true).toList();
  if (productList.length < 15) {
    await Product(
      name: 'Notebook 12"',
      description: '128 GB SSD i7',
      price: 6899,
      categoryId: 1,
      date: DateTime(2020, 01, 01),
      datetime: DateTime(2020, 01, 01, 12),
    ).save();

    await Product(
            name: 'Notebook 12"',
            description: '256 GB SSD i7',
            price: 8244,
            categoryId: 1,
            date: DateTime(2020, 01, 02),
            datetime: DateTime(2020, 01, 02, 13))
        .save();
    await Product(
            name: 'Notebook 12"',
            description: '512 GB SSD i7',
            price: 9214,
            categoryId: 1,
            date: DateTime(2020, 01, 03),
            datetime: DateTime(2020, 01, 03, 14))
        .save();

    await Product(
            name: 'Notebook 13"',
            description: '128 GB SSD',
            price: 8500,
            categoryId: 1,
            date: DateTime(2020, 01, 04),
            datetime: DateTime(2020, 01, 04, 15))
        .save();
    await Product(
            name: 'Notebook 13"',
            description: '256 GB SSD',
            price: 9900,
            categoryId: 1,
            date: DateTime(2020, 01, 05),
            datetime: DateTime(2020, 01, 05, 16))
        .save();
    await Product(
            name: 'Notebook 13"',
            description: '512 GB SSD',
            price: 11000,
            categoryId: 1,
            date: DateTime(2020, 01, 06),
            datetime: DateTime(2020, 01, 06, 17))
        .save();

    await Product(
            name: 'Notebook 15"',
            description: '128 GB SSD',
            price: 8999,
            categoryId: 1,
            date: DateTime(2020, 01, 07),
            datetime: DateTime(2020, 01, 07, 18))
        .save();
    await Product(
            name: 'Notebook 15"',
            description: '256 GB SSD',
            price: 10499,
            categoryId: 1,
            date: DateTime(2020, 01, 08),
            datetime: DateTime(2020, 01, 08, 19))
        .save();
    await Product(
            name: 'Notebook 15"',
            description: '512 GB SSD',
            price: 11999,
            categoryId: 1,
            date: DateTime(2020, 01, 09),
            datetime: DateTime(2020, 01, 09, 20))
        .save();

    await Product(
            name: 'Ultrabook 13"',
            description: '128 GB SSD i5',
            price: 9954,
            categoryId: 2)
        .save();
    await Product(
            name: 'Ultrabook 13"',
            description: '256 GB SSD i5',
            price: 11154,
            categoryId: 2)
        .save();
    await Product(
            name: 'Ultrabook 13"',
            description: '512 GB SSD i5',
            price: 13000,
            categoryId: 2)
        .save();

    await Product(
            name: 'Ultrabook 15"',
            description: '128 GB SSD i7',
            price: 11000,
            categoryId: 2)
        .save();
    await Product(
            name: 'Ultrabook 15"',
            description: '256 GB SSD i7',
            price: 12000,
            categoryId: 2)
        .save();
    await Product(
            name: 'Ultrabook 15"',
            description: '512 GB SSD i7',
            price: 14000,
            categoryId: 2)
        .save();
    print('added 15 new products');

    await Product(name: 'Product 1').save();
    await Product(name: 'Product 2').save();
    await Product(name: 'Product 3').save();
    await Product(name: 'Product 4').save();
    await Product(name: 'Product 5').save();
    print('added 5 dummy products');
  }
  return true;
}

void sampleModelConvert() {
  final seq = SqfEntitySequenceBase()
    ..sequenceName = 'sample'
    ..init();

  final model = MyDb()
    ..databaseName = 'sampleORM.db'
    ..sequences = [seq]
    ..databaseTables = [
      SqfEntityTableBase()
        ..dbModel = 'myyymodelll'
        ..defaultJsonUrl = 'none'
        ..fields = [
          SqfEntityFieldBase('name', DbType.text)..defaultValue = 'test',
          SqfEntityFieldBase('identity', DbType.text, sequencedBy: seq)
            ..defaultValue = 'test'
        ]
        ..primaryKeyName = 'id'
        ..primaryKeyType = PrimaryKeyType.integer_auto_incremental
        ..tableName = 'category'
        ..useSoftDeleting = true
        ..init()
    ];

  final modelStr = SqfEntityConverter(model).createEntites();
  print(modelStr);
}

class MyDb extends SqfEntityModelBase {}
