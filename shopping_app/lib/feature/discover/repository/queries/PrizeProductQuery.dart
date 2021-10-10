const String getPrizeProductQuery = r'''
query(){
  products(first: 1, query: "title: مسابقة على الكرسي الخارق") {
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