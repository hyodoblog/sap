import * as dotenv from 'dotenv'
dotenv.config()

const rootCollection = process.env.FIREBASE_STORE_ROOT_COLLECTION as string
const baseUrl = process.env.BASE_URL as string
const stripeAccount = process.env.STRIPE_ACCOUNT as string
const storageBucketName = process.env.FIREBASE_STORAGE_BUCKET as string

const envSendGrid = {
  apiKey: process.env.SENDGRID_API_KEY as string,
  templateId: {
    invitation: process.env.SENDGRID_TAMPLATE_ID_INVITATION as string,
  },
  email: {
    noreply: process.env.SENDGRID_FROM_EMAIL_NOREPLY as string,
  },
}

export { rootCollection, baseUrl, stripeAccount, storageBucketName, envSendGrid }
