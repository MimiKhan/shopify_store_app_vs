enum DeliveryMethodType {
  LOCAL,
  NONE,
  PICKUP_POINT,
  PICK_UP,
  RETAIL,
  SHIPPING
}

extension ParseToStringArticle on DeliveryMethodType{
  String parseToString(){
    return toString().split('.')[1];
  }
}