import firebase from 'firebase/app'
import { SapApp } from '~/modules/types/models'

export class SapAppDb {
  private sapAppsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.sapAppsRef = db.collection('sapApps')
  }

  public getUid(): string {
    return this.sapAppsRef.doc().id
  }

  public async getItems(userUid: string): Promise<SapApp[]> {
    const items: SapApp[] = []
    const docs = await this.sapAppsRef.where('userUid', '==', userUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as SapApp)
    })
    return items
  }

  public async getItem(uid: string): Promise<SapApp | null> {
    const doc = await this.sapAppsRef.doc(uid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as SapApp
    } else {
      return null
    }
  }

  public async setItem(item: SapApp): Promise<void> {
    await this.sapAppsRef.doc().set({
      ...item,
      createdAt: firebase.firestore.FieldValue.serverTimestamp(),
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as SapApp)
  }

  public async updateItem(uid: string, item: SapApp): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.sapAppsRef.doc(uid).update({
      ...item,
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as SapApp)
  }

  public async deleteItem(uid: string): Promise<void> {
    await this.sapAppsRef.doc(uid).delete()
  }
}
