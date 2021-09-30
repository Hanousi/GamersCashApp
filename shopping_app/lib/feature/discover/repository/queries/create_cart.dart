const String createCartMutation = r'''
mutation createCart($cartInput : CartInput) {
  cartCreate(input: $cartInput) {
    cart {
      id
    }
  }
}

''';