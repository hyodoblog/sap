import {
  CollectionReference,
  DocumentReference,
  collection,
  getDocs,
  getDoc,
  doc,
  setDoc,
  serverTimestamp,
  updateDoc,
  deleteDoc,
} from 'firebase/firestore'
import { RoomMessage } from '~/modules/types/models'

export class RoomMessageDb {
  private roomsRef: CollectionReference

  constructor(rootRef: DocumentReference) {
    this.roomsRef = collection(rootRef, 'rooms')
  }

  private chatsRef(roomUid: string): CollectionReference {
    return collection(this.roomsRef, roomUid, 'chats')
  }

  public async getItems(roomUid: string): Promise<RoomMessage[]> {
    const items: RoomMessage[] = []
    const docs = await getDocs(this.chatsRef(roomUid))
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomMessage)
    })
    return items
  }

  public async getItem(roomUid: string, groupUid: string): Promise<RoomMessage> {
    const _doc = await getDoc(doc(this.chatsRef(roomUid), groupUid))
    if (_doc.exists()) {
      return {
        uid: _doc.id,
        ..._doc.data(),
      } as RoomMessage
    } else throw Error
  }

  public async setItem(roomUid: string, item: RoomMessage): Promise<void> {
    await setDoc(doc(this.chatsRef(roomUid)), {
      ...item,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    })
  }

  public async updateItem(roomUid: string, groupUid: string, item: RoomMessage): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await updateDoc(doc(this.chatsRef(roomUid), groupUid), {
      ...item,
      updatedAt: serverTimestamp(),
    })
  }

  public async deleteItem(roomUid: string, groupUid: string): Promise<void> {
    await deleteDoc(doc(this.chatsRef(roomUid), groupUid))
  }
}
