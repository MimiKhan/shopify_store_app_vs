const String getCartWebUrl = r'''
query($id: ID!) {
  node(id: $id) {
    ... on Cart {
      webUrl
    }
  }
}
''';