const String getNProductsWithCollectionQuery = r'''
query($n : Int, $category : String){
  collections(first: 1, query: $category) {
    edges {
      node {
        products(first: $n) {
          edges {
            node {
              id,
              title,
              tags,
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
    }
  }
}

''';