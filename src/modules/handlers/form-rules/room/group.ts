export default class {
  name = [(v: any) => !!v || '入力してください', (v: any) => (v && v.length <= 30) || '30文字以内で入力してください']
  description = [(v: any) => !v || (v && v.length <= 100) || '100文字以内で入力してください']
  priority = [
    (v: any) => !!v || '入力してください',
    (v: any) => (v && Number.isFinite(Number(v))) || '半角数字で入力してください',
    (v: any) => (v >= 0 && v <= 10) || '0より大きく10より小さい半角数字を入力してください',
  ]
}
