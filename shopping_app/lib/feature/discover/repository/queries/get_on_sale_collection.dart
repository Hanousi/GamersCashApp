const String getOnSaleCollectionQuery = r'''
{
	collections(query: "title:On Sale", first: 1) {
    edges {
      node {
        products(first: 6) {
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
    }
  }
}

''';