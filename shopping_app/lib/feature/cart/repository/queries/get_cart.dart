const String getCartQuery = r'''
query($cartId : ID!){
  cart(id: $cartId) {
    checkoutUrl
    lines(first:10) {
      edges {
        node {
          id
          quantity
          merchandise {
            ... on ProductVariant {
              product {
                id,
                title,
                description,
                productType,
                variants(first: 1) {
                  edges {
                    node {
                      id
                      price
                      compareAtPrice
                    }
                  }
                }
                images(first:10) {
                  edges {
                    node {
                      originalSrc
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    estimatedCost {
      totalAmount {
        amount
        currencyCode
      }
      subtotalAmount {
        amount
        currencyCode
      }
      totalTaxAmount {
        amount
        currencyCode
      }
      totalDutyAmount {
        amount
        currencyCode
      }
    }
  }
}

''';