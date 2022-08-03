import { credential } from 'firebase-admin'
import { getApps, initializeApp } from 'firebase-admin/app'
import { FieldValue, getFirestore, Timestamp } from 'firebase-admin/firestore'

if (!getApps().length) {
  initializeApp({
    credential: credential.cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.GCLOUD_CLIENT_EMAIL,
      privateKey: process.env.GCLOUD_PRIVATE_KEY!.replace(/\\n/g, '\n'),
    }),
  })
}

// firestore
export const db = getFirestore()
export const envRef = db.collection('envs').doc(process.env.FIREBASE_STORE_ROOT_COLLECTION!)
export const usersRef = envRef.collection('users')
export const roomsRef = envRef.collection('rooms')

export const getNowAt = (): Timestamp => {
  return Timestamp.now()
}

export const getServerTimestamp = (): Timestamp => {
  return FieldValue.serverTimestamp() as Timestamp
}
