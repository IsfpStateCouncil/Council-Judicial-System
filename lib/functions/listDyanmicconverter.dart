List<String> convertDynamicListToStringList(List<dynamic> dynamicList) {
  // Use map to convert each dynamic item to a string
  List<String> stringList = dynamicList.map((dynamic item) => item.toString()).toList();
  return stringList;
}