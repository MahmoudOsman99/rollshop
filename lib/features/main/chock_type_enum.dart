enum ChockTypes {
  TOS,
  BOS,
  TDS,
  BDS,
  TopThurstChock,
  bottom_thurst_chock,
  Piston,
}

class ChockTypeEnumDetailes {
  static List<String> getNames() {
    return [
      'TOP Operator Side',
      'Bottom Operator Side',
      'TOP Drive Side',
      'Bottom Drive Side',
      'TOP Thurst Chock',
      'Bottom Thurst Chock',
      'Piston',
    ];
  }
  // static List<String> getNames() {
  //   return ChockTypes.values.map((chock) => chock.name).toList();
  // }
}
