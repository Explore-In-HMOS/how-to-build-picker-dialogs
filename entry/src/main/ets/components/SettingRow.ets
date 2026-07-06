@ComponentV2
export struct SettingRow {
  @Param title: ResourceStr = $r('app.string.empty');
  @Param value: ResourceStr = $r('app.string.empty');
  @Param buttonText: ResourceStr = $r('app.string.empty');
  @Param buttonBgColor: ResourceColor = $r('app.color.row_btn_default_bg');
  @Event onClickButton: () => void = () => {
  };

  build() {
    Row() {
      Column() {
        Text(this.title)
          .fontSize(11)
          .fontColor($r('app.color.row_title_white'))
          .fontWeight(FontWeight.Medium)
        Text(this.value)
          .fontSize(10)
          .fontColor($r('app.color.row_value_gray'))
      }
      .alignItems(HorizontalAlign.Start)

      Button(this.buttonText, { type: ButtonType.Normal })
        .borderRadius(6)
        .height(20)
        .width(60)
        .backgroundColor(this.buttonBgColor)
        .fontSize(10)
        .onClick(() => {
          this.onClickButton();
        })
    }
    .width('85%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(8)
    .backgroundColor($r('app.color.row_bg_transparent'))
    .borderRadius(8)
  }
}