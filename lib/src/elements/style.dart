class Style {
  String background, backgroundColor, backgroundImage, color, padding;

  Style({this.background, this.backgroundImage, this.padding});

  Map<String, String> compile() {
    return {
      'background': background,
      'background-color': backgroundColor,
      'background-image': backgroundImage,
      'color': color,
      'padding': padding,
    };
  }
}
