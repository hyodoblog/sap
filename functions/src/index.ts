import * as functions from 'firebase-functions'
import * as express from 'express'
import * as sgMail from '@sendgrid/mail'
import * as dotenv from 'dotenv'
dotenv.config()

const router: express.Router = express.Router()

sgMail.setApiKey(process.env.SENDGRID_API_KEY as string)

router.post('/', async (req: express.Request, res: express.Response) => {
  const apiKey = process.env.API_KEY
  const api_key = req.query.api_key
  const name = req.query.name
  const login_link = req.query.login_link
  const email = req.query.email as string
  const password_init = req.query.password_init
  console.log(req.query)
  console.log(req.query.email)
  try {
    if (api_key === apiKey) {
      const html = `
        <p>${name}様</p>
        <p>SAPログインページが発行され、希望提出ができるようになりました。</p>
        <p>以下のログイン情報を基にログインしてください。</p>
        <p><a href="${login_link}">ログインページ</a></p>
        <p>Eメール：${email}</p>
        <p>パスワード：${password_init}</p>
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

const app = express()
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(router)

export const sapSendMail = functions.region('asia-northeast1').https.onRequest(app)
