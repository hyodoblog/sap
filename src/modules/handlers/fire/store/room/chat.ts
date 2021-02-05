import firebase from 'firebase/app'
import { Chat } from '~/modules/types/models'

export class ChatDb {
  private appsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.appsRef = db.collection('apps')
  }

  private chatsRef(appUid: string): firebase.firestore.CollectionReference {
    return this.appsRef.doc(appUid).collection('chats')
  }

  public async getItems(appUid: string): Promise<Chat[]> {
    const items: Chat[] = []
    const docs = await this.chatsRef(appUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as Chat)
    })
    return items
  }

  public async getItem(appUid: string, chatUid: string): Promise<Chat | null> {
    const doc = await this.chatsRef(appUid).doc(chatUid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as Chat
    } else {
      return null
    }
  }

  public async setItem(appUid: string, item: Chat): Promise<void> {
    await this.chatsRef(appUid)
      .doc()
      .set({
        ...item,
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      })
  }

  public async updateItem(appUid: string, chatUid: string, item: Chat): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.chatsRef(appUid)
      .doc(chatUid)
      .update({
        ...item,
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      } as Chat)
  }

  public async deleteItem(appUid: string, chatUid: string): Promise<void> {
    await this.chatsRef(appUid).doc(chatUid).delete()
  }
}
