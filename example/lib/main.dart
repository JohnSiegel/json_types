import 'package:json_types/json.dart';

/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// properties.
final class ExampleObject extends Json {
  final stringJson = Json.string('myStringKey');
  final doubleJson = Json.double('myDoubleKey');
  final intJson = Json.int('myIntKey');
  final boolJson = Json.boolean('myBoolKey');

  String get myString => stringJson.value;
  double get myDouble => doubleJson.value;
  int get myInt => intJson.value;
  bool get myBool => boolJson.value;

  ExampleObject.parser() : super();

  ExampleObject.parse(super.json) : super.parse();

  ExampleObject.populated({
    required String str,
    required double d,
    required int i,
    required bool b,
  }) : super() {
    stringJson.populate(str);
    doubleJson.populate(d);
    intJson.populate(i);
    boolJson.populate(b);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringJson, doubleJson, intJson, boolJson];
}

/// Create a [ExampleObject] from in-memory data.
final object1 =
    ExampleObject.populated(str: 'exampleStr', d: 12.5, i: 10, b: false);

/// A JSON representation of [object1].
final objectJson1 = {
  'myStringKey': 'exampleStr',
  'myDoubleKey': 12.5,
  'myIntKey': 10,
  'myBoolKey': false,
};

/// Create another [ExampleObject] from in-memory data.
final object2 =
    ExampleObject.populated(str: 'exampleStr2', d: 102.5, i: -5, b: true);

/// A JSON representation of [object2].
final objectJson2 = {
  'string': 'exampleStr2',
  'double': 102.5,
  'int': -5,
  'bool': true,
};

/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// objects with inheritance.
sealed class ExamplePolymorphic extends JsonPolymorphic<ExamplePolymorphic> {
  final stringJson = Json.string('string');
  final doubleJson = Json.double('double');

  String get myString => stringJson.value;
  double get myDouble => doubleJson.value;

  ExamplePolymorphic() : super();

  ExamplePolymorphic.parse(super.json) : super.parse();

  factory ExamplePolymorphic.polymorphicParse(
    Map<String, dynamic> json,
    List<ExamplePolymorphic Function()> parsers,
  ) =>
      JsonPolymorphic.polymorphicParse(json, parsers);

  ExamplePolymorphic.populated({
    required String str,
    required double d,
  }) : super() {
    stringJson.populate(str);
    doubleJson.populate(d);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys => [stringJson, doubleJson];
}

/// Example of a class that extends [ExamplePolymorphic] and uses [JsonKey]s to
/// define objects with inheritance.
final class ExamplePolymorphicA extends ExamplePolymorphic {
  final intJson = Json.int('int');
  final boolJson = Json.boolean('bool');

  int get myInt => intJson.value;
  bool get myBool => boolJson.value;

  ExamplePolymorphicA.parser() : super();

  ExamplePolymorphicA.parse(super.json) : super.parse();

  ExamplePolymorphicA.populated({
    required super.str,
    required super.d,
    required int i,
    required bool b,
  }) : super.populated() {
    intJson.populate(i);
    boolJson.populate(b);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [...super.keys, intJson, boolJson];
}

/// Another example of a class that extends [ExamplePolymorphic] and uses
/// [JsonKey]s to define objects with inheritance.
final class ExamplePolymorphicB extends ExamplePolymorphic {
  final stringListJson = Json.stringList('stringList');
  final doubleListJson = Json.doubleList('doubleList');

  List<String> get myStringList => stringListJson.value;
  List<double> get myDoubleList => doubleListJson.value;

  ExamplePolymorphicB.parser() : super();

  ExamplePolymorphicB.parse(super.json) : super.parse();

  ExamplePolymorphicB.populated({
    required super.str,
    required super.d,
    required List<String> stringList,
    required List<double> doubleList,
  }) : super.populated() {
    stringListJson.populate(stringList);
    doubleListJson.populate(doubleList);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [...super.keys, stringListJson, doubleListJson];
}

/// Create a [ExamplePolymorphicA] from in-memory data.
final polymorphicA = ExamplePolymorphicA.populated(
  str: 'exampleStr',
  d: 12.5,
  i: 10,
  b: false,
);

/// A JSON representation of [polymorphicA].
final polymorphicJsonA = {
  '__poly__': 'ExamplePolymorphicA',
  'string': 'exampleStr',
  'double': 12.5,
  'int': 10,
  'bool': false,
};

final polymorphicB = ExamplePolymorphicB.populated(
  str: 'exampleStr',
  d: 12.5,
  stringList: ['string1', 'string2'],
  doubleList: [2.5, 3.5],
);

/// A JSON representation of [polymorphicB].
final polymorphicJsonB = {
  '__poly__': 'ExamplePolymorphicB',
  'string': 'exampleStr',
  'double': 12.5,
  'stringList': ['string1', 'string2'],
  'doubleList': [2.5, 3.5],
};

/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// maps.
final class ExampleMaps extends Json {
  final stringMap = Json.stringMap('myStringMapKey');
  final doubleMap = Json.doubleMap('myDoubleMapKey');
  final intMap = Json.intMap('myIntMapKey');
  final booleanMap = Json.booleanMap('myBooleanMapKey');
  final objectMap = Json.objectMap('myObjectMapKey', ExampleObject.parser);
  final polymorphicMap = Json.polymorphicMap(
    'myPolymorphicMapKey',
    [ExamplePolymorphicA.parser, ExamplePolymorphicB.parser],
  );

  Map<String, String> get myStringMap => stringMap.value;
  Map<String, double> get myDoubleMap => doubleMap.value;
  Map<String, int> get myIntMap => intMap.value;
  Map<String, bool> get myBooleanMap => booleanMap.value;
  Map<String, ExampleObject> get myObjectMap => objectMap.value;
  Map<String, ExamplePolymorphic> get myPolymorphicMap => polymorphicMap.value;

  ExampleMaps.parser() : super();

  ExampleMaps.parse(super.json) : super.parse();

  ExampleMaps.populated({
    required Map<String, String> stringMap,
    required Map<String, double> doubleMap,
    required Map<String, int> intMap,
    required Map<String, bool> booleanMap,
    required Map<String, ExampleObject> objectMap,
    required Map<String, ExamplePolymorphic> polymorphicMap,
  }) : super() {
    this.stringMap.populate(stringMap);
    this.doubleMap.populate(doubleMap);
    this.intMap.populate(intMap);
    this.booleanMap.populate(booleanMap);
    this.objectMap.populate(objectMap);
    this.polymorphicMap.populate(polymorphicMap);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringMap, doubleMap, intMap, booleanMap, objectMap, polymorphicMap];
}

/// Create a [ExampleMaps] from in-memory data.
final maps = ExampleMaps.populated(
  stringMap: {'string1': 'value1', 'string2': 'value2'},
  doubleMap: {'double1': 2.5, 'double2': 3.5},
  intMap: {'int1': 3, 'int2': 4},
  booleanMap: {'bool1': false, 'bool2': true},
  objectMap: {'object1': object1, 'object2': object2},
  polymorphicMap: {'polymorphicA': polymorphicA, 'polymorphicB': polymorphicB},
);

/// A JSON representation of [maps].
final mapsJson = {
  'stringMap': {
    'string1': 'value1',
    'string2': 'value2',
  },
  'doubleMap': {
    'double1': 2.5,
    'double2': 3.5,
  },
  'intMap': {
    'int1': 3,
    'int2': 4,
  },
  'booleanMap': {
    'bool1': false,
    'bool2': true,
  },
  'objectMap': {
    'object1': objectJson1,
    'object2': objectJson2,
  },
  'polymorphicMap': {
    'polymorphicA': polymorphicJsonA,
    'polymorphicB': polymorphicJsonB,
  },
};

/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// lists.
final class ExampleLists extends Json {
  final stringList = Json.stringList('myStringListKey');
  final doubleList = Json.doubleList('myDoubleListKey');
  final intList = Json.intList('myIntListKey');
  final boolList = Json.booleanList('myBoolListKey');
  final objectList = Json.objectList('myObjectListKey', ExampleObject.parser);
  final polymorphicList = Json.polymorphicList(
    'myPolymorphicListKey',
    [ExamplePolymorphicA.parser, ExamplePolymorphicB.parser],
  );

  List<String> get myStringList => stringList.value;
  List<double> get myDoubleList => doubleList.value;
  List<int> get myIntList => intList.value;
  List<bool> get myBoolList => boolList.value;
  List<ExampleObject> get myObjectList => objectList.value;
  List<ExamplePolymorphic> get myPolymorphicList => polymorphicList.value;

  ExampleLists.parser() : super();

  ExampleLists.parse(super.json) : super.parse();

  ExampleLists.populated({
    required List<String> stringList,
    required List<double> doubleList,
    required List<int> intList,
    required List<bool> boolList,
    required List<ExampleObject> objectList,
    required List<ExamplePolymorphic> polymorphicList,
  }) : super() {
    this.stringList.populate(stringList);
    this.doubleList.populate(doubleList);
    this.intList.populate(intList);
    this.boolList.populate(boolList);
    this.objectList.populate(objectList);
    this.polymorphicList.populate(polymorphicList);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringList, doubleList, intList, boolList, objectList, polymorphicList];
}

/// Create a [ExampleLists] from in-memory data.
final lists = ExampleLists.populated(
  stringList: ['string1', 'string2'],
  doubleList: [2.5, 3.5],
  intList: [3, 4],
  boolList: [false, true],
  objectList: [object1, object2],
  polymorphicList: [polymorphicA, polymorphicB],
);

/// A JSON representation of [lists].
final listsJson = {
  'stringList': [
    'string1',
    'string2',
  ],
  'doubleList': [
    2.5,
    3.5,
  ],
  'intList': [
    3,
    4,
  ],
  'boolList': [
    false,
    true,
  ],
  'objectList': [
    objectJson1,
    objectJson2,
  ],
  'polymorphicList': [
    polymorphicJsonA,
    polymorphicJsonB,
  ],
};

/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// nested objects.
final class ExampleAggregateObject extends Json {
  final objectJson = Json.object('myObjectKey', ExampleObject.parser);
  final mapsJson = Json.object('myMapsKey', ExampleMaps.parser);
  final listsJson = Json.object('myListsKey', ExampleLists.parser);

  ExampleObject get myObject => objectJson.value;
  ExampleMaps get myMaps => mapsJson.value;
  ExampleLists get myLists => listsJson.value;

  ExampleAggregateObject.parser() : super();

  ExampleAggregateObject.parse(super.json) : super.parse();

  ExampleAggregateObject.populated({
    required ExampleObject object,
    required ExampleMaps maps,
    required ExampleLists lists,
  }) : super() {
    objectJson.populate(object);
    mapsJson.populate(maps);
    listsJson.populate(lists);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys => [objectJson, mapsJson, listsJson];
}

/// Create a [ExampleAggregateObject] from in-memory data.
final aggregateObject =
    ExampleAggregateObject.populated(object: object1, maps: maps, lists: lists);

/// A JSON representation of [aggregateObject].
final aggregateObjectJson = {
  'object': objectJson1,
  'maps': mapsJson,
  'lists': listsJson,
};

void main() {
  assert(object1.toJson() == objectJson1);
  assert(ExampleObject.parse(objectJson1) == object1);

  assert(object2.toJson() == objectJson2);
  assert(ExampleObject.parse(objectJson2) == object2);

  assert(polymorphicA.toJson() == polymorphicJsonA);
  assert(ExamplePolymorphicA.parse(polymorphicJsonA) == polymorphicA);

  assert(polymorphicB.toJson() == polymorphicJsonB);
  assert(ExamplePolymorphicB.parse(polymorphicJsonB) == polymorphicB);

  assert(ExamplePolymorphic.polymorphicParse(polymorphicJsonA, [
        ExamplePolymorphicA.parser,
        ExamplePolymorphicB.parser,
      ]) ==
      polymorphicA);

  assert(ExamplePolymorphic.polymorphicParse(polymorphicJsonB, [
        ExamplePolymorphicA.parser,
        ExamplePolymorphicB.parser,
      ]) ==
      polymorphicB);

  assert(maps.toJson() == mapsJson);
  assert(ExampleMaps.parse(mapsJson) == maps);

  assert(lists.toJson() == listsJson);
  assert(ExampleLists.parse(listsJson) == lists);

  assert(aggregateObject.toJson() == aggregateObjectJson);
  assert(ExampleAggregateObject.parse(aggregateObjectJson) == aggregateObject);
}
