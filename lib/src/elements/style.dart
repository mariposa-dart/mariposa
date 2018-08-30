class Style {
  String background, backgroundImage, padding;

  Style({this.background, this.backgroundImage, this.padding});

  Map<String, String> compile() {
    return {
      'background': background,
      'background-image': backgroundImage,
      'padding': padding,
    };
  }
}
