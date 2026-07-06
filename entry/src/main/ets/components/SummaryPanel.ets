@ComponentV2
export struct SummaryPanel {
  @Param selectedDateStr: ResourceStr = $r('app.string.empty');
  @Param selectedTime: ResourceStr = $r('app.string.empty');
  @Param repeatPattern: ResourceStr = $r('app.string.empty');
  @Param selectedSound: ResourceStr = $r('app.string.empty');
  @Event onReset: () => void = () => {
  };

  build() {
    Column({ space: 4 }) {
      Row() {
        Text($r('app.string.summary_title'))
          .fontSize(9)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.summary_title_orange'))

        Button($r('app.string.dialog_reset_action'),
          { type: ButtonType.Normal })
          .borderRadius(4)
          .height(16)
          .width(60)
          .backgroundColor($r('app.color.summary_reset_bg'))
          .fontSize(8)
          .fontColor($r('app.color.summary_reset_font'))
          .onClick(() => {
            this.onReset();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().color($r('app.color.summary_panel_border'))

      Text($r('app.string.summary_date_format', this.selectedDateStr))
        .fontColor($r('app.color.summary_text_white'))
        .fontSize(9)
      Text($r('app.string.summary_time_format', this.selectedTime))
        .fontColor($r('app.color.summary_text_white'))
        .fontSize(9)
      Text($r('app.string.summary_repeat_format', this.repeatPattern))
        .fontColor($r('app.color.summary_text_white'))
        .fontSize(9)
      Text($r('app.string.summary_sound_format', this.selectedSound))
        .fontColor($r('app.color.summary_text_white'))
        .fontSize(9)
    }
    .width('85%')
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .backgroundColor($r('app.color.summary_panel_bg'))
    .borderRadius(8)
    .border({ width: 1, color: $r('app.color.summary_panel_border') })
  }
}