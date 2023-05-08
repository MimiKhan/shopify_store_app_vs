const String getCollectionByIdQuery = r'''
query($id : ID!, $cursor : String, $sortKey: ProductCollectionSortKeys){
  node(id: $id) {
    ... on Collection {
      id
      description
      descriptionHtml
      handle
      title
      updatedAt
      image {
        id
        url
        originalSrc
      }
      products(first: 10, sortKey: $sortKey, after: $cursor) {
        edges {
          cursor
          node {
          options(first: 50) {
            id
            name
            values
            } 
            availableForSale
            collections(first: 250) {
              edges {
                node {
                  description
                  descriptionHtml
                  handle
                  id
                  title
                  updatedAt
                }
              }
            }
            createdAt
            description
            descriptionHtml
            handle
            id
            images(first: 250) {
              edges {
                node {
                  id
                  url
                  originalSrc
                }
              }
            }
            onlineStoreUrl
            productType
            publishedAt
            tags
            title
            updatedAt
            vendor
            variants(first: 250) {
              edges {
                node {
                  title
                  image {
                    id
                    url
                    originalSrc
                  }
                  priceV2 {
                    amount
                    currencyCode
                  }
                  compareAtPriceV2 {
                    amount
                    currencyCode
                  }
                  weight
                  weightUnit
                  sku
                  requiresShipping
                  selectedOptions {
                    name
                    value
                  }
                  availableForSale
                  id
                  quantityAvailable
                  unitPrice {
                      amount
                      currencyCode
                  }
                  unitPriceMeasurement {
                      measuredType
                      quantityUnit
                      quantityValue
                      referenceUnit
                      referenceValue
                  }
                }
              }
            }
          }
        }
      pageInfo{
        hasNextPage
        }}
    }
  }
}
''';
