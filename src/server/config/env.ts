const stripeAccount = process.env.STRIPE_ACCOUNT as string
const storageBucketName = process.env.FIREBASE_STORAGE_BUCKET as string

export { stripeAccount, storageBucketName }
