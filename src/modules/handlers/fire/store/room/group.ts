import firebase from 'firebase/app'
import { Group } from '~/modules/types/models'

export class GroupDb {
  private appsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.appsRef = db.collection('apps')
  }

  private groupsRef(appUid: string): firebase.firestore.CollectionReference {
    return this.appsRef.doc(appUid).collection('groups')
  }

  public async getItems(appUid: string): Promise<Group[]> {
    const items: Group[] = []
    const docs = await this.groupsRef(appUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as Group)
    })
    return items
  }

  public async getItem(appUid: string, groupUid: string): Promise<Group | null> {
    const doc = await this.groupsRef(appUid).doc(groupUid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as Group
    } else {
      return null
    }
  }

  public async setItem(appUid: string, item: Group): Promise<void> {
    await this.groupsRef(appUid)
      .doc()
      .set({
        ...item,
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      })
  }

  public async updateItem(appUid: string, groupUid: string, item: Group): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.groupsRef(appUid)
      .doc(groupUid)
      .update({
        ...item,
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      } as Group)
  }

  public async deleteItem(appUid: string, groupUid: string): Promise<void> {
    await this.groupsRef(appUid).doc(groupUid).delete()
  }
}
