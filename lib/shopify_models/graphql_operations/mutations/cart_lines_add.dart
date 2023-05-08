
const String cartLinesAddMutation = r'''
  mutation cartLinesAdd($cartId: ID!, $lines: [CartLineInput!]!) {
    cartLinesAdd(cartId: $cartId, lines: $lines) {
      cart {
        id
        lines(first: 10) {
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
                priceV2 {
                  amount
                  currencyCode
                }
              }
            }
          }
        }
      }
      userErrors {
        code
        field
        message
      }
    }
  }
''';
