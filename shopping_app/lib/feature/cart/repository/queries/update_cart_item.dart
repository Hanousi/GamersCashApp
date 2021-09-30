const String updateCartItemMutation = r'''
mutation cartUpdateLines($lines : [CartLineUpdateInput!]!, $cartId : ID!) {
  cartLinesUpdate(lines: $lines, cartId: $cartId) {
    cart {
      id
    }
  }
}

''';