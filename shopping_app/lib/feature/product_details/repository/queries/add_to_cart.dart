const String addToCartMutation = r'''
mutation cartAddLines($lines : [CartLineInput!]!, $cartId : ID!) {
  cartLinesAdd(lines: $lines, cartId: $cartId) {
    cart {
      id
    }
  }
}

''';