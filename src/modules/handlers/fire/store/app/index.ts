import firebase from 'firebase/app'
import { App } from '~/modules/types/models'

export class AppDb {
  private appsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.appsRef = db.collection('apps')
  }

  public async getItems(userUid: string): Promise<App[]> {
    const items: App[] = []
    const docs = await this.appsRef.where('userUid', '==', userUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as App)
    })
    return items
  }

  public async getItem(uid: string): Promise<App | null> {
    const doc = await this.appsRef.doc(uid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as App
    } else {
      return null
    }
  }

  public async setItem(item: App): Promise<void> {
    await this.appsRef.doc().set({
      ...item,
      createdAt: firebase.firestore.FieldValue.serverTimestamp(),
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as App)
  }

  public async updateItem(uid: string, item: App): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.appsRef.doc(uid).update({
      ...item,
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as App)
  }

  public async deleteItem(uid: string): Promise<void> {
    await this.appsRef.doc(uid).delete()
  }
}
