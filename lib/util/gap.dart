extension Gap<E> on List<E> {
  List<E> gap(E separator) =>
      expand((e) => [separator, e]).skip(1).toList();
}
