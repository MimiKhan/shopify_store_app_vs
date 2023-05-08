
// define the mutation string for cartDiscountCodesUpdate
const String cartDiscountCodesUpdateMutation = r'''
mutation cartDiscountCodesUpdate($cartId: ID!, $discountCodes: [String!]!) {
  cartDiscountCodesUpdate(
    id: $cartId
    discountCodes: $discountCodes
  ) {
    cart {
      buyerIdentity {
        countryCode
        email
        phone
      }
      checkoutUrl
      cost {
        subtotalAmount {
          amount
          currencyCode
        }
        totalAmount {
          amount
          currencyCode
        }
        totalTaxAmount {
          amount
          currencyCode
        }
      }
      createdAt
      discountAllocations {
        discountedAmount {
          amount
          currencyCode
        }
      }
      discountCodes {
        applicable
        code
      }
      estimatedCost {
        totalAmount {
          amount
          currencyCode
        }
      }
      id
      note
      totalQuantity
      lines(first: 10) {
        nodes {
          id
          quantity
          merchandise {
            ... on ProductVariant {
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
    cartUserErrors {
      code
      field
      message
    }
  }
}
''';