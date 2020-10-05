import { Router, Request, Response } from 'express'
import * as sgMail from '@sendgrid/mail'
import * as dotenv from 'dotenv'
dotenv.config()

const router: Router = Router()

sgMail.setApiKey(process.env.SENDGRID_API_KEY as string)

export default router.post('/', async (req: Request, res: Response) => {
  const apiKey = process.env.API_KEY
  const api_key = req.body.params.api_key
  const university_name = req.body.params.university_name
  const department_name = req.body.params.department_name
  const faculty_name = req.body.params.faculty_name
  const name = req.body.params.name
  const login_link = req.body.params.login_link
  const email = req.body.params.email
  const password_init = req.body.params.password_init
  const end_datetime = req.body.params.end_datetime
  const view_end_datetime = req.body.params.view_end_datetime
  console.log(req.body)
  console.log(req.body.params)
  console.log(req.body.params.email)
  console.log(req.body.params['email'])
  try {
    if (api_key === apiKey) {
      const html = `
        <p>${university_name} ${faculty_name} ${department_name}</p>
        <p>${name}様</p>
        <p>SAPログインページが発行され、希望提出ができるようになりました。</p>
        <p>以下のログイン情報を基にログインしてください。</p>
        <p><a href="${login_link}">ログインページ</a></p>
        <p>Eメール：${email}</p>
        <p>パスワード：${password_init}</p>
        <p>希望提出締め切り：${end_datetime}</p>
        <p>配属一覧閲覧期限：${view_end_datetime}</p>
        <p>それでは、良い配属になることを祈っております。</p>
      `
      const msg = {
        to: email,
        from: 'sap@example.com',
        subject: 'SAPログイン通知',
        text: 'sap',
        html
      }
      await sgMail.send(msg)
    }
    res.send('success')
  } catch (err) {
    console.log('メール送信でエラー発生')
    console.log(email)
    res.send('error')
  }
})
