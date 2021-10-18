export default class {
  displayName = [
    (v: any) => !!v || '入力してください',
    (v: any) => (v && v.length <= 30) || '30文字以内で入力してください',
  ]

  email = [
    (v: any) => !!v || '入力してください',
    (v: any) => /.+@.+\..+/.test(v) || 'メールアドレス形式で入力してください',
  ]
}
