// Mutation for updating selected delivery option for a cart
const String updateSelectedDeliveryOptionMutation = r'''
  mutation updateSelectedDeliveryOption($cartId: ID!, $deliveryOptionId: ID!) {
    cartShippingAddressUpdateV2(
      id: $cartId,
      shippingAddress: {
        selectedShippingRate: {
          deliveryOptionId: $deliveryOptionId
        }
      }
    ) {
      cart {
        ...CartFields
      }
      userErrors {
        ...ErrorFields
      }
    }
  }
  
  fragment CartFields on Cart {
    id
    webUrl
    subtotalPriceV2 {
      amount
      currencyCode
    }
    totalTaxV2 {
      amount
      currencyCode
    }
    totalPriceV2 {
      amount
      currencyCode
    }
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
          variant {
            id
            title
            image {
              originalSrc
              altText
            }
            priceV2 {
              amount
              currencyCode
            }
          }
          quantity
        }
      }
    }
    shippingAddress {
      firstName
      lastName
      address1
      address2
      city
      province
      country
      zip
      phone
    }
    selectedShippingRate {
      handle
      priceV2 {
        amount
        currencyCode
      }
      title
    }
  }
  
  fragment ErrorFields on UserError {
    field
    message
  }
''';