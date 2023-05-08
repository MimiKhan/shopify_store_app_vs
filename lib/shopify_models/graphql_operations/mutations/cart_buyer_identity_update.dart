String updateCartBuyerIdentityMutation = r'''
  mutation cartBuyerIdentityUpdate($cartId: ID!, $buyerIdentity: CartBuyerIdentityUpdateInput!) {
    cartBuyerIdentityUpdate(cartId: $cartId, buyerIdentity: $buyerIdentity) {
      cart {
        buyerIdentity {
          countryCode
          deliveryAddressPreferences {
            ... on MailingAddress {
              id
              name
              address1
              address2
              city
              country
              firstName
              phone
              lastName
              province
              zip
            }
          }
          email
          phone
        }
        checkoutUrl
        cost {
          subtotalAmount {
            amount
            currencyCode
          }
          subtotalAmountEstimated
          totalAmount {
            amount
            currencyCode
          }
          totalAmountEstimated
          totalDutyAmountEstimated
          totalTaxAmountEstimated
          totalTaxAmount {
            amount
            currencyCode
          }
          totalDutyAmount {
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
          subtotalAmount {
            amount
            currencyCode
          }
          totalAmount {
            amount
            currencyCode
          }
          totalDutyAmount {
            amount
            currencyCode
          }
          totalTaxAmount {
            amount
            currencyCode
          }
        }
        id
        note
        updatedAt
        totalQuantity
        lines(first: 10) {
          nodes {
            cost {
              amountPerQuantity {
                amount
                currencyCode
              }
              compareAtAmountPerQuantity {
                amount
                currencyCode
              }
              subtotalAmount {
                amount
                currencyCode
              }
              totalAmount {
                amount
                currencyCode
              }
            }
            discountAllocations {
              discountedAmount {
                amount
                currencyCode
              }
            }
            id
            merchandise {
              ... on ProductVariant {
                id
                priceV2 {
                  amount
                  currencyCode
                }
                quantityAvailable
                requiresShipping
                sku
                title
                weight
                weightUnit
                selectedOptions {
                  name
                  value
                }
                availableForSale
                image {
                  originalSrc
                  url
                  id
                }
              }
            }
            quantity
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
