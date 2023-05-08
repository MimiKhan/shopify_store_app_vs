
const String removeCartLinesMutation = r'''
  mutation removeCartLines($cartId: ID!, $lineItemIds: [ID!]!) {
    cartLinesRemove(cartId: $cartId, lineItemIds: $lineItemIds) {
      cart {
        id
        lines(first: 10) {
          nodes {
            id
            quantity
            merchandise {
              ... on ProductVariant {
                id
              }
            }
          }
        }
      }
      cartUserErrors {
        code
        field
        message
      }
    }
  }
''';
