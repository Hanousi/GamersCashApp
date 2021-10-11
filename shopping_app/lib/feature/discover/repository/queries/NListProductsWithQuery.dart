const String getNProductsWithQuery = r'''
query($n : Int, $myQuery : String){
  products(first: $n, query: $myQuery) {
    edges {
      node {
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
              availableForSale
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

''';