import firebase from 'firebase/app'
import { ParticipateUser } from '~/modules/types/models'

export class ParticipateUserDb {
  private appsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.appsRef = db.collection('apps')
  }

  private participateUsersRef(appUid: string): firebase.firestore.CollectionReference {
    return this.appsRef.doc(appUid).collection('participateUsers')
  }

  public async getItems(appUid: string): Promise<ParticipateUser[]> {
    const items: ParticipateUser[] = []
    const docs = await this.participateUsersRef(appUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as ParticipateUser)
    })
    return items
  }

  public async getItem(appUid: string, groupUid: string): Promise<ParticipateUser | null> {
    const doc = await this.participateUsersRef(appUid).doc(groupUid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as ParticipateUser
    } else {
      return null
    }
  }

  public async setItem(appUid: string, item: ParticipateUser): Promise<void> {
    await this.participateUsersRef(appUid)
      .doc()
      .set({
        ...item,
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      })
  }

  public async updateItem(appUid: string, groupUid: string, item: ParticipateUser): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.participateUsersRef(appUid)
      .doc(groupUid)
      .update({
        ...item,
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      } as ParticipateUser)
  }

  public async deleteItem(appUid: string, groupUid: string): Promise<void> {
    await this.participateUsersRef(appUid).doc(groupUid).delete()
  }
}
