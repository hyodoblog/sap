import * as admin from 'firebase-admin'

const serviAccount = require(`../../../key/${process.env.NODE_ENV}.json`)

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviAccount),
    projectId: process.env.FIREBASE_PROJECT_ID,
    serviceAccountId: process.env.GCLOUD_SERVICE_ACCOUNT_ID,
  })
}

export const db = admin.firestore()
export const usersRef = rootRef.collection('users')
export const roomsRef = rootRef.collection('rooms')

export const getNowTimestamp = () => admin.firestore.Timestamp.now()
export const getServerTimestamp = () => admin.firestore.FieldValue.serverTimestamp()

export { admin }
