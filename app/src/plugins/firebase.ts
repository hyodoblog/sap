import firebase from 'firebase/app'
import 'firebase/analytics'
import 'firebase/auth'
import 'firebase/firestore'
import 'firebase/storage'
import { AuthFire } from 'app/src/modules/handlers/fire/auth'
import { StorageFire } from 'app/src/modules/handlers/fire/storage'
import { StoreFire } from 'app/src/modules/handlers/fire/store'

export interface FirebaseApi {
  auth: AuthFire
  storage: StorageFire
  store: StoreFire
}

export default function (_: any, inject: (arg0: string, arg1: FirebaseApi) => void) {
  const config = {
    apiKey: process.env.FIREBASE_API_KEY,
    authDomain: process.env.FIREBASE_AUTH_DOMAIN,
    projectId: process.env.FIREBASE_PROJECT_ID,
    storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
    messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
    appId: process.env.FIREBASE_APP_ID,
    measurementId: process.env.MEASUREMENT_ID as string,
  }

  if (!firebase.apps.length) {
    firebase.initializeApp(config)
  }

  const fire: FirebaseApi = {
    auth: new AuthFire(firebase.auth()),
    storage: new StorageFire(firebase.storage()),
    store: new StoreFire(firebase.firestore()),
  }

  if (process.client) {
    firebase.analytics()
  }

  inject('fire', fire)
}
