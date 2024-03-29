part of 'json_list.dart';

/// A [JsonKey] that parses a list of [Json] objects.
sealed class _JsonList<T, Serializable>
    extends JsonKey<List<T>, List<Serializable>> {
  _JsonList.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (list) => list.map((e) => parser(e)).toList());

  _JsonList.populated(super.key, super.val) : super.populated();
}

sealed class _JsonOptionalList<T, Serializable>
    extends JsonKey<List<T>?, List<Serializable>?> {
  _JsonOptionalList.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (list) => list?.map((e) => parser(e)).toList());

  _JsonOptionalList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of primitives.
abstract base class _JsonPrimitiveList<T> extends _JsonList<T, T> {
  _JsonPrimitiveList.parser(String key) : super.parser(key, parsePrimitive);

  _JsonPrimitiveList.populated(super.key, super.val) : super.populated();

  @override
  List<T> serialize(List<T> val) => val;
}

/// A [JsonKey] that parses an optional list of primitives.
abstract base class _JsonOptionalPrimitiveList<T>
    extends _JsonOptionalList<T, T> {
  _JsonOptionalPrimitiveList.parser(String key)
      : super.parser(key, parsePrimitive);

  _JsonOptionalPrimitiveList.populated(super.key, super.val)
      : super.populated();

  @override
  List<T>? serialize(List<T>? val) => val;
}
