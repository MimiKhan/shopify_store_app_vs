const String cartLinesUpdateMutation = r'''
mutation cartLinesUpdateV2($cartId: ID!, $lines: [CartLineUpdateInput!]!) {
  cartLinesUpdateV2(cartId: $cartId, lines: $lines) {
    cart {
      ...CartFragment
    }
    userErrors {
      code
      field
      message
    }
  }
}

fragment CartFragment on Cart {
  id
  email
  note
  requiresShipping
  currencyCode
  totalTax
  totalPrice
  lineItems(first: 250) {
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
    edges {
      cursor
      node {
        id
        title
        quantity
        variant {
          id
          title
          image {
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
          product {
            id
            title
            handle
            images(first: 1) {
              pageInfo {
                hasNextPage
                hasPreviousPage
              }
              edges {
                node {
                  originalSrc
                }
              }
            }
            variants(first: 1) {
              edges {
                node {
                  id
                  priceV2 {
                    amount
                    currencyCode
                  }
                  compareAtPriceV2 {
                    amount
                    currencyCode
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
