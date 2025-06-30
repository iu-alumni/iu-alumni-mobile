extension Gap<E> on Iterable<E> {
  List<E> gap(E separator) => expand((e) => [separator, e]).skip(1).toList();

  Iterable<E> gapI(E separator) => expand((e) => [separator, e]).skip(1);
}
