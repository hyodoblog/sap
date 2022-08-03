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
import { Room } from '~/modules/types/models'

export class RoomDb {
  private roomsRef: CollectionReference

  constructor(rootRef: DocumentReference) {
    this.roomsRef = collection(rootRef, 'rooms')
  }

  public getUid(): string {
    return doc(this.roomsRef).id
  }

  public async getItems(userUid: string): Promise<Room[]> {
    const items: Room[] = []
    const docs = await getDocs(query(this.roomsRef, where('userUid', '==', userUid)))
    docs.forEach((_doc) => {
      if (_doc.exists()) {
        items.push({
          uid: _doc.id,
          ..._doc.data(),
        } as Room)
      }
    })
    return items
  }

  public async getItem(uid: string): Promise<Room> {
    const _doc = await getDoc(doc(this.roomsRef, uid))
    if (_doc.exists()) {
      return {
        uid: _doc.id,
        ..._doc.data(),
      } as Room
    } else throw Error
  }

  public async setItem(item: Room): Promise<void> {
    await setDoc(doc(this.roomsRef), {
      ...item,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    } as Room)
  }

  public async updateItem(uid: string, item: Room): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await updateDoc(doc(this.roomsRef, uid), {
      ...item,
      updatedAt: serverTimestamp(),
    })
  }
}
