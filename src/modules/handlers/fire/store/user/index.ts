import firebase from 'firebase/app'
import { Gender, User } from '~/modules/types/models'

export class UserDb {
  private usersRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.usersRef = db.collection('users')
  }

  private getInitData(): User {
    return {
      email: '',
      nichName: '',
      description: '',
      gender: Gender.OTHER,
    }
  }

  public async getItem(uid: string): Promise<User | null> {
    const doc = await this.usersRef.doc(uid).get()
    if (doc.exists) {
      return doc.data() as User
    } else {
      return null
    }
  }

  public async setInit(uid: string): Promise<User> {
    const item = this.getInitData()
    await this.usersRef.doc(uid).set({
      ...item,
      createdAt: firebase.firestore.FieldValue.serverTimestamp(),
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as User)
    return item
  }

  public async updateItem(uid: string, user: User): Promise<void> {
    delete user.uid
    delete user.updatedAt
    await this.usersRef.doc(uid).update({
      ...user,
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as User)
  }
}
