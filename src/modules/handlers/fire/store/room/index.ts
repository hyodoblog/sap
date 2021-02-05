import firebase from 'firebase/app'
import { Room } from '~/modules/types/models'

export class RoomDb {
  private roomsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.roomsRef = db.collection('rooms')
  }

  public getUid(): string {
    return this.roomsRef.doc().id
  }

  public async getItems(userUid: string): Promise<Room[]> {
    const items: Room[] = []
    const docs = await this.roomsRef.where('userUid', '==', userUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as Room)
    })
    return items
  }

  public async getItem(uid: string): Promise<Room | null> {
    const doc = await this.roomsRef.doc(uid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as Room
    } else {
      return null
    }
  }

  public async setItem(item: Room): Promise<void> {
    await this.roomsRef.doc().set({
      ...item,
      createdAt: firebase.firestore.FieldValue.serverTimestamp(),
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as Room)
  }

  public async updateItem(uid: string, item: Room): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.roomsRef.doc(uid).update({
      ...item,
      updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
    } as Room)
  }

  public async deleteItem(uid: string): Promise<void> {
    await this.roomsRef.doc(uid).delete()
  }
}
