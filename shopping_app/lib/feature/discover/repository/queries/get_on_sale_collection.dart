const String getOnSaleCollectionQuery = r'''
{
	collections(query: "title:عروض اسبوعية", first: 1) {
    edges {
      node {
        products(first: 250) {
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
    }
  }
}

''';