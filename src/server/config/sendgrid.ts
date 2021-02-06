import sgMail from '@sendgrid/mail'
import { envSendGrid } from './env'

sgMail.setApiKey(envSendGrid.apiKey)

export default sgMail
