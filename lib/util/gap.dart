extension Gap<E> on List<E> {
  List<E> gap(E Function(E) separator) =>
      expand((e) => [separator(e), e]).skip(1).toList();
}
