import firebase from 'firebase/app'
import { RoomMessage } from '~/modules/types/models'

export class RoomMessageDb {
  private roomsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.roomsRef = db.collection('rooms')
  }

  private chatsRef(appUid: string): firebase.firestore.CollectionReference {
    return this.roomsRef.doc(appUid).collection('chats')
  }

  public async getItems(appUid: string): Promise<RoomMessage[]> {
    const items: RoomMessage[] = []
    const docs = await this.chatsRef(appUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomMessage)
    })
    return items
  }

  public async getItem(appUid: string, chatUid: string): Promise<RoomMessage | null> {
    const doc = await this.chatsRef(appUid).doc(chatUid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as RoomMessage
    } else {
      return null
    }
  }

  public async setItem(appUid: string, item: RoomMessage): Promise<void> {
    await this.chatsRef(appUid)
      .doc()
      .set({
        ...item,
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      })
  }

  public async updateItem(appUid: string, chatUid: string, item: RoomMessage): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.chatsRef(appUid)
      .doc(chatUid)
      .update({
        ...item,
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      } as RoomMessage)
  }

  public async deleteItem(appUid: string, chatUid: string): Promise<void> {
    await this.chatsRef(appUid).doc(chatUid).delete()
  }
}
