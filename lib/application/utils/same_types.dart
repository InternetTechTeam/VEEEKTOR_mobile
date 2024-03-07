bool sameTypes<S, V>() {
  void func<X extends S>() {}
  // Dart spec says this is only true if S and V are "the same type".
  return func is void Function<X extends V>();
}