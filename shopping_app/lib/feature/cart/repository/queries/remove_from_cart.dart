const String removeFromCartMutation = r'''
mutation cartRemoveLines($lineIds : [ID!]!, $cartId : ID!) {
  cartLinesRemove(lineIds: $lineIds, cartId: $cartId) {
    cart {
      id
    }
  }
}

''';