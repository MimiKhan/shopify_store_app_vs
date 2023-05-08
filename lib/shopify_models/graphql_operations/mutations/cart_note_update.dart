const String cartNoteUpdateMutation = r'''
mutation($id: ID!, $note: String!) {
  cartNoteUpdate(id: $id, note: $note) {
    cart {
      id
      note
    }
    userErrors {
      field
      message
    }
  }
}

''';