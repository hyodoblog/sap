import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
import { serviceAccountId, storeEnv } from './env'

const serviAccount = require(`../../key/gcloud.json`)

admin.initializeApp({
  serviceAccountId,
  credential: admin.credential.cert(serviAccount),
})

// firestore
export const db = admin.firestore()
export const envRef = db.collection('envs').doc(storeEnv)
export const usersRef = envRef.collection('users')
export const roomsRef = envRef.collection('rooms')

export const getNowAt = (): admin.firestore.Timestamp => {
  return admin.firestore.Timestamp.now()
}

export const getServerTimestamp = (): admin.firestore.Timestamp => {
  return admin.firestore.FieldValue.serverTimestamp() as admin.firestore.Timestamp
}

export { admin, functions }
