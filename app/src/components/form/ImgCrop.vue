<template lang="pug">
  .img-form
    //- loading
    .img-form_loading(v-if="loading")
      v-progress-circular(
        indeterminate
        color="primary"
      )
    //- canvas
    .img-form_canvas(v-show="imgDataURL")
      canvas(:id="canvasId")
      v-menu(v-if="!disabled" offset-y)
        template(v-slot:activator="{ on, attrs }")
          .img-form_canvas_btn.text-center.align-center(v-bind="attrs" v-on="on")
            v-icon(color="white") mdi-dots-vertical
        v-list
          v-list-item
            v-btn(text prepend-icon="mdi-pencil" @click="editOn") 編集する
          v-list-item
            v-btn(text color="error" @click="destroy") 削除する

    //- edit cropper
    v-dialog(v-model="editDialog" max-width="600")
      v-card.pa-4
        VueCropper(
          ref="cropper"
          :aspect-ratio="maxWidth/maxHeight"
          :src="beforeImgDataURL"
          :guides="true"
          :view-mode="2"
          drag-mode="crop"
          :auto-crop-area="0.5"
          :background="true"
          :rotatable="false"
        )
        .error--text.my-3 {{ maxWidth }}px × {{ maxHeight }}px で切り取りされます。
        v-btn(block color="warning" elevation="0" @click="crop") 切り抜く

    //- input
    label.img-form_label(
      v-if="!imgDataURL"
      for="file"
    )
      .img-form_label_content.text-center
        v-icon.mb-1 mdi-image-plus
        p.ma-0 画像を追加
      input#file.img-form_input(
        type="file"
        accept="image/png,image/jpeg"
        @change="setImg"
      )
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue, Watch } from 'nuxt-property-decorator'
import 'cropperjs/dist/cropper.css'
import VueCropper from 'vue-cropperjs'

@Component({
  components: { VueCropper },
})
export default class extends Vue {
  @Prop({ type: Boolean, default: false }) readonly isUpdate: boolean
  @Prop({ type: Number, default: false }) readonly maxWidth: number
  @Prop({ type: Number, default: false }) readonly maxHeight: number
  @Prop({ type: String, default: 'crop-canvas' }) readonly canvasId: string
  @Prop({ type: Boolean, required: true }) readonly disabled: boolean
  @PropSync('imgDataURLValue', { type: String, required: true }) imgDataURL!: string

  beforeMount() {
    if (this.imgDataURL) {
      this.displayCanvas(this.imgDataURL)
    } else {
      this.loading = false
    }
    if (!this.isUpdate) {
      this.loading = false
    }
  }

  @Watch('imgDataURL')
  onChangeImgDataURL() {
    if (this.imgDataURL) this.displayCanvas(this.imgDataURL)
  }

  loading = true
  editDialog = false
  beforeImgDataURL = ''

  displayCanvas(imgDataURL: string, isCrop?: boolean) {
    const canvas = document.querySelector(`#${this.canvasId}`)
    // @ts-ignore
    const ctx = canvas.getContext('2d')

    const img = new Image()
    img.src = imgDataURL
    img.onload = () => {
      if (isCrop) {
        // @ts-ignore
        canvas.width = this.maxWidth
        // @ts-ignore
        canvas.height = this.maxHeight
        let width: number, height: number, xOffset: number, yOffset: number
        if (img.width > img.height) {
          height = this.maxHeight
          width = img.width * (this.maxHeight / img.height)
          xOffset = -(width - this.maxWidth) / 2
          yOffset = 0
        } else {
          width = this.maxWidth
          height = img.height * (this.maxWidth / img.width)
          yOffset = -(height - this.maxHeight) / 2
          xOffset = 0
        }
        ctx.drawImage(img, xOffset, yOffset, width, height)
        this.imgDataURL = ctx.canvas.toDataURL()
      } else {
        // @ts-ignore
        ctx.drawImage(img, 0, 0, canvas.width, canvas.height)
      }
      this.loading = false
    }
    img.onerror = (e: any) => {
      console.error(e)
    }
  }

  setImg(file: any) {
    this.$emit('input')
    const reader = new FileReader()
    reader.onload = (e: any) => {
      const imgDataURL = e.target.result as string
      this.beforeImgDataURL = imgDataURL
      this.displayCanvas(imgDataURL, true)
    }
    reader.readAsDataURL(file.target.files[0])
  }

  editOn() {
    if (!this.beforeImgDataURL) {
      this.beforeImgDataURL = this.imgDataURL
    }
    this.editDialog = true
  }

  crop() {
    this.$emit('input')
    // @ts-ignore
    const imgDataURL = this.$refs.cropper
      // @ts-ignore
      .getCroppedCanvas({
        width: this.maxWidth,
        height: this.maxHeight,
      })
      .toDataURL()
    this.displayCanvas(imgDataURL)
    this.imgDataURL = imgDataURL
    this.editDialog = false
  }

  destroy() {
    this.imgDataURL = ''
    this.beforeImgDataURL = ''
  }
}
</script>

<style lang="scss" scoped>
.img-form {
  position: relative;
  width: 160px;
  height: 160px;
  background: white;

  &_loading {
    position: absolute;
    width: 100%;
    height: 100%;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    z-index: 1000;

    & > * {
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
  }

  &_canvas {
    position: relative;
    width: 100%;
    height: 100%;

    & > canvas {
      width: 100%;
      height: 100%;
    }

    &_btn {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 32px;
      height: 32px;
      border-radius: 4px;
      background: rgba(0, 30, 72, 0.4);

      & > i {
        width: 100%;
        height: 100%;
      }

      &:hover {
        cursor: pointer;
      }
    }
  }

  &_label {
    position: relative;
    width: 160px;
    height: 160px;
    display: block;
    color: rgba(30, 61, 107, 0.2);
    border: dashed 1px rgba(30, 61, 107, 0.2);
    // border-style: dashed;
    border-radius: 8px;

    &:hover {
      cursor: pointer;
      opacity: 0.9;
    }

    &_content {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
  }

  &_input {
    display: none;
    width: 100%;
    height: 100%;
  }
}
</style>
