import { SelectDialogV2, AdvancedDialogV2Button } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

@ComponentV2
export struct SoundSelectDialog {
  @Param radioIndex: number = 2;
  @Event onSoundSelected: (index: number, name: string) => void = () => {
  };
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;

  private getString(resource: Resource): string {
    return this.context.resourceManager.getStringSync(resource.id);
  }

  build() {
    SelectDialogV2({
      title: $r('app.string.dialog_sound_title'),
      selectedIndex: this.radioIndex,
      confirm: new AdvancedDialogV2Button({
        content: $r('app.string.dialog_cancel'),
        action: () => {
        }
      }),
      radioContent: [
        {
          title: $r('app.string.sound_nature'),
          action: () => {
            this.onSoundSelected(0, this.getString($r('app.string.sound_nature')));
          }
        },
        {
          title: $r('app.string.sound_classic'),
          action: () => {
            this.onSoundSelected(1, this.getString($r('app.string.sound_classic')));
          }
        },
        {
          title: $r('app.string.sound_digital'),
          action: () => {
            this.onSoundSelected(2, this.getString($r('app.string.sound_digital')));
          }
        }
      ]
    })
  }
}