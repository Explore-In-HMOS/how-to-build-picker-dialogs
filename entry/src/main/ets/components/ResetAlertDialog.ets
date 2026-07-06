import { AlertDialogV2, AdvancedDialogV2Button } from '@kit.ArkUI';

@ComponentV2
export struct ResetAlertDialog {
  @Event onReset: () => void = () => {
  };

  build() {
    AlertDialogV2({
      primaryTitle: $r('app.string.dialog_reset_title'),
      content: $r('app.string.dialog_reset_content'),
      primaryButton: new AdvancedDialogV2Button({
        content: $r('app.string.dialog_cancel'),
        action: () => {
        }
      }),
      secondaryButton: new AdvancedDialogV2Button({
        content: $r('app.string.dialog_reset_action'),
        role: ButtonRole.ERROR,
        action: () => {
          this.onReset();
        }
      })
    })
  }
}