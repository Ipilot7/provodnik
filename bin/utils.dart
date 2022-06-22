mixin Utils {
  
}

extension MyExtentio on String {
  back() {
    List<String> str = split("/").toList();
    String newStr = '';
    for (int i = 0; i < str.length - 1; i++) {
      if (i == 0) {
        newStr += "${str[i]}";
      } else {
        newStr += "/${str[i]}";
      }
      return newStr;
    }
  }
}
