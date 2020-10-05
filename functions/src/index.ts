import * as functions from 'firebase-functions'
import * as express from 'express'
import routes from './routes'

const app = express()
app.use(express.urlencoded({ extended: true }))
app.use(routes)

export const sapSendMail = functions.region('asia-northeast1').https.onRequest(app)
