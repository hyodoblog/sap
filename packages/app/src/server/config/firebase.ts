import { credential } from 'firebase-admin'
import { getApps, initializeApp } from 'firebase-admin/app'
import { getAuth } from 'firebase-admin/auth'
import { getFirestore, Timestamp, FieldValue } from 'firebase-admin/firestore'
import { rootCollection } from './env'

if (!getApps().length) {
  initializeApp({
    credential: credential.cert({
      projectId: process.env.FB_PROJECT_ID,
      clientEmail: process.env.GCLOUD_CLIENT_EMAIL,
      privateKey: process.env.GCLOUD_PRIVATE_KEY!.replace(/\\n/g, '\n'),
    }),
  })
}

export const auth = getAuth()
export const db = getFirestore()
const rootRef = db.collection('envs').doc(rootCollection)
export const usersRef = rootRef.collection('users')
export const roomsRef = rootRef.collection('rooms')

export const getNowTimestamp = () => Timestamp.now()
export const getServerTimestamp = () => FieldValue.serverTimestamp()
