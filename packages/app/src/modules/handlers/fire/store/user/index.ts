import {
  collection,
  CollectionReference,
  doc,
  DocumentReference,
  getDoc,
  getDocs,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
} from 'firebase/firestore'
import { User } from '~/modules/types/models'

export class UserDb {
  private usersRef: CollectionReference

  constructor(rootRef: DocumentReference) {
    this.usersRef = collection(rootRef, 'users')
  }

  private getInitData(nickname: string, email: string): User {
    return {
      email,
      nickname,
    }
  }

  public async isUserToEmail(email: string): Promise<boolean> {
    const docs = await getDocs(query(this.usersRef, where('email', '==', email)))
    return !docs.empty
  }

  public async getItem(uid: string): Promise<User | null> {
    const _doc = await getDoc(doc(this.usersRef, uid))
    if (_doc.exists()) {
      return _doc.data() as User
    } else {
      return null
    }
  }

  public async setInit(uid: string, nickname: string, email: string): Promise<User> {
    const item = this.getInitData(nickname, email)
    await setDoc(doc(this.usersRef, uid), {
      ...item,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    } as User)
    return item
  }

  public async updateItem(uid: string, user: User): Promise<void> {
    delete user.uid
    delete user.updatedAt
    await updateDoc(doc(this.usersRef, uid), {
      ...user,
      updatedAt: serverTimestamp(),
    } as User)
  }
}
