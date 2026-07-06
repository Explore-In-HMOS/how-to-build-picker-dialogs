import { ConfirmDialogV2, AdvancedDialogV2Button } from '@kit.ArkUI';

@ComponentV2
export struct SaveConfirmDialog {
  @Param checked: boolean = false;
  @Event onCheckedChange: (checked: boolean) => void = () => {
  };
  @Event onConfirm: () => void = () => {
  };

  build() {
    ConfirmDialogV2({
      title: $r('app.string.dialog_save_title'),
      content: $r('app.string.dialog_save_content'),
      checked: this.checked,
      checkTips: $r('app.string.dialog_check_tips'),
      primaryButton: new AdvancedDialogV2Button({
        content: $r('app.string.dialog_deny'),
        action: () => {
        }
      }),
      secondaryButton: new AdvancedDialogV2Button({
        content: $r('app.string.dialog_allow'),
        action: () => {
          this.onConfirm();
        }
      }),
      onCheckedChange: (checked: boolean) => {
        this.onCheckedChange(checked);
      }
    })
  }
}