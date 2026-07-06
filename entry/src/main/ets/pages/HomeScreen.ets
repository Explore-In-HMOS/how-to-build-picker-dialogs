import { SettingRow } from '../components/SettingRow';
import { SummaryPanel } from '../components/SummaryPanel';
import { SoundSelectDialog } from '../components/SoundSelectDialog';
import { SaveConfirmDialog } from '../components/SaveConfirmDialog';
import { ResetAlertDialog } from '../components/ResetAlertDialog';

@Entry
@ComponentV2
struct HomeScreen {
  @Local selectedDate: Date = new Date('2024-03-05');
  @Local selectedTime: string = '07:30';
  @Local repeatPattern: ResourceStr = $r('app.string.pattern_weekdays');
  @Local selectedSound: ResourceStr = $r('app.string.sound_nature');
  @Local isTimePickerVisible: boolean = false;
  @Local checked: boolean = false;
  @Local radioIndex: number = 2;
  @Local repeatIndex: number | number[] = 2;
  private isPickerOpen: boolean = false;
  private pickerTime: Date = new Date('2022-07-22T07:30:00');
  private patterns: TextPickerRangeContent[] = [
    { icon: '', text: $r('app.string.pattern_once') },
    { icon: '', text: $r('app.string.pattern_daily') },
    { icon: '', text: $r('app.string.pattern_weekdays') },
    { icon: '', text: $r('app.string.pattern_weekends') }
  ];

  @Builder
  soundSelectDialogBuilder() {
    SoundSelectDialog({
      radioIndex: this.radioIndex,
      onSoundSelected: (index, name) => {
        this.radioIndex = index;
        this.selectedSound = name;
      }
    })
  }

  @Builder
  resetAlertDialogBuilder() {
    ResetAlertDialog({
      onReset: () => {
        this.selectedTime = '07:30';
        this.repeatPattern = $r('app.string.pattern_weekdays');
        this.selectedSound = $r('app.string.sound_nature');
        this.radioIndex = 2;
      }
    })
  }

  @Builder
  saveConfirmDialogBuilder() {
    SaveConfirmDialog({
      checked: this.checked,
      onCheckedChange: (checked) => {
        this.checked = checked;
      },
      onConfirm: () => {
        console.info('Alarm saved successfully.');
      }
    })
  }

  build() {
    Scroll() {
      Column({ space: 8 }) {
        Text($r('app.string.home_title'))
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.home_title_white'))
          .margin({ top: 12 })

        SettingRow({
          title: $r('app.string.label_date'),
          value: this.selectedDate.toLocaleDateString(),
          buttonText: $r('app.string.btn_pick'),
          buttonBgColor: $r('app.color.home_btn_orange'),
          onClickButton: () => {
            CalendarPickerDialog.show({
              selected: this.selectedDate,
              onAccept: (value: Date) => {
                this.selectedDate = value;
              }
            });
          }
        })

        SettingRow({
          title: $r('app.string.label_time'),
          value: this.selectedTime,
          buttonText: this.isTimePickerVisible ? $r('app.string.btn_close') : $r('app.string.btn_set'),
          buttonBgColor: $r('app.color.row_btn_default_bg'),
          onClickButton: () => {
            this.isTimePickerVisible = !this.isTimePickerVisible;
          }
        })

        if (this.isTimePickerVisible) {
          Column() {
            TimePicker({
              selected: this.pickerTime
            })
              .disappearTextStyle(
                { color: $r('app.color.home_picker_disappear_text'), font: { size: 14, weight: FontWeight.Lighter } })
              .textStyle({ color: $r('app.color.home_picker_text'), font: { size: 16, weight: FontWeight.Normal } })
              .selectedTextStyle(
                { color: $r('app.color.home_btn_orange'), font: { size: 18, weight: FontWeight.Bolder } })
              .height(60)
              .onChange((value: TimePickerResult) => {
                if (value.hour >= 0) {
                  this.pickerTime.setHours(value.hour, value.minute);
                  let hourStr = value.hour < 10 ? `0${value.hour}` : value.hour.toString();
                  let minStr = value.minute < 10 ? `0${value.minute}` : value.minute.toString();
                  this.selectedTime = `${hourStr}:${minStr}`;
                }
              })
          }
          .width('85%')
          .backgroundColor($r('app.color.home_picker_inline_bg'))
          .borderRadius(8)
          .padding(4)
        }

        SettingRow({
          title: $r('app.string.label_repeat'),
          value: this.repeatPattern,
          buttonText: $r('app.string.btn_edit'),
          buttonBgColor: $r('app.color.row_btn_default_bg'),
          onClickButton: () => {
            if (this.isPickerOpen) {
              return;
            }
            this.isPickerOpen = true;

            this.getUIContext().showTextPickerDialog({
              canLoop: false,
              range: this.patterns,
              selected: this.repeatIndex,
              defaultPickerItemHeight: 40,
              onAccept: (value: TextPickerResult) => {
                if (Array.isArray(value.index)) {
                  this.repeatIndex = value.index[0];
                } else {
                  this.repeatIndex = value.index;
                }
                this.repeatPattern = value.value as string;
                this.isPickerOpen = false;
              },
              onCancel: () => {
                this.isPickerOpen = false;
              }
            });
          }
        })

        SettingRow({
          title: $r('app.string.label_sound'),
          value: this.selectedSound,
          buttonText: $r('app.string.btn_audio'),
          buttonBgColor: $r('app.color.row_btn_default_bg'),
          onClickButton: () => {
            this.getUIContext().getPromptAction().openCustomDialog({
              alignment: DialogAlignment.Center,
              builder: () => {
                this.soundSelectDialogBuilder()
              }
            });
          }
        })

        SummaryPanel({
          selectedDateStr: this.selectedDate.toLocaleDateString(),
          selectedTime: this.selectedTime,
          repeatPattern: this.repeatPattern,
          selectedSound: this.selectedSound,
          onReset: () => {
            this.getUIContext().getPromptAction().openCustomDialog({
              alignment: DialogAlignment.Center,
              builder: () => {
                this.resetAlertDialogBuilder()
              }
            });
          }
        })

        Button($r('app.string.btn_save'))
          .width('50%')
          .height(28)
          .fontSize(12)
          .backgroundColor($r('app.color.home_btn_orange'))
          .margin({ bottom: 15 })
          .onClick(() => {
            this.getUIContext().getPromptAction().openCustomDialog({
              alignment: DialogAlignment.Center,
              builder: () => {
                this.saveConfirmDialogBuilder()
              }
            });
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.home_bg_black'))
    .padding(16)
  }
}