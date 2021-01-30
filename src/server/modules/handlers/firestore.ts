import { usersRef } from '../../config/firebase'
import { User } from '../../../modules/types/models'
import { getServerTimestamp } from './firebase'

// *******************
// /users

export const firestoreGetUser = async (uid: string): Promise<User | null> => {
  const doc = await usersRef.doc(uid).get()
  if (doc.exists) {
    return doc.data() as User
  } else {
    return null
  }
}

export const firestoreUpdateUser = async (uid: string, item: User): Promise<void> => {
  delete item.uid
  delete item.updatedAt
  await usersRef.doc(uid).update({ ...item, updatedAt: getServerTimestamp() } as User)
}
