const String getPrizeProductQuery = r'''
query(){
  products(first: 3, query: "title: 'Last winner' OR 'Date for competition' OR 'مسابقة على الكرسي الخارق'") {
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