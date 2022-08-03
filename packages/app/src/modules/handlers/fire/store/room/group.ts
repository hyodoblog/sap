import {
  CollectionReference,
  DocumentReference,
  collection,
  getDocs,
  query,
  orderBy,
  getDoc,
  doc,
  setDoc,
  serverTimestamp,
  updateDoc,
  deleteDoc,
} from 'firebase/firestore'
import { RoomGroup } from '~/modules/types/models'

export class RoomGroupDb {
  private roomsRef: CollectionReference

  constructor(rootRef: DocumentReference) {
    this.roomsRef = collection(rootRef, 'rooms')
  }

  private groupsRef(roomUid: string): CollectionReference {
    return collection(this.roomsRef, roomUid, 'groups')
  }

  public async getItems(roomUid: string): Promise<RoomGroup[]> {
    const items: RoomGroup[] = []
    const docs = await getDocs(query(this.groupsRef(roomUid), orderBy('displayName')))
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomGroup)
    })
    return items
  }

  public async getItem(roomUid: string, groupUid: string): Promise<RoomGroup> {
    const _doc = await getDoc(doc(this.groupsRef(roomUid), groupUid))
    if (_doc.exists()) {
      return {
        uid: _doc.id,
        ..._doc.data(),
      } as RoomGroup
    } else throw Error
  }

  public async getItemToLoginToken(roomUid: string, groupUid: string, loginToken: string): Promise<RoomGroup> {
    const _doc = await getDoc(doc(this.groupsRef(roomUid), groupUid))
    if (_doc.exists() && _doc.data()?.loginToken === loginToken) {
      return {
        uid: _doc.id,
        ..._doc.data(),
      } as RoomGroup
    } else throw Error
  }

  public async setItem(roomUid: string, item: RoomGroup): Promise<void> {
    await setDoc(doc(this.groupsRef(roomUid)), {
      ...item,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    })
  }

  public async updateItem(roomUid: string, groupUid: string, item: RoomGroup): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await updateDoc(doc(this.groupsRef(roomUid), groupUid), {
      ...item,
      updatedAt: serverTimestamp(),
    })
  }

  public async deleteItem(roomUid: string, groupUid: string): Promise<void> {
    await deleteDoc(doc(this.groupsRef(roomUid), groupUid))
  }
}
