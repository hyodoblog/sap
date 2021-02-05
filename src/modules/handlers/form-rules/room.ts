export default class {
  name = [(v: any) => !!v || '入力してください', (v: any) => (v && v.length <= 30) || '30文字以内で入力してください']
  description = [
    (v: any) => !!v || '入力してください',
    (v: any) => (v && v.length <= 100) || '100文字以内で入力してください',
  ]
}
