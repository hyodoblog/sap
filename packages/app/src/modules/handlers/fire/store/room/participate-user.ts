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
import { RoomParticipateUser } from '~/modules/types/models'

export class RoomParticipateUserDb {
  private roomsRef: CollectionReference

  constructor(rootRef: DocumentReference) {
    this.roomsRef = collection(rootRef, 'rooms')
  }

  private participateUsersRef(roomUid: string): CollectionReference {
    return collection(this.roomsRef, roomUid, 'participateUsers')
  }

  public async getItems(roomUid: string): Promise<RoomParticipateUser[]> {
    const items: RoomParticipateUser[] = []
    const docs = await getDocs(query(this.participateUsersRef(roomUid), orderBy('displayName')))
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomParticipateUser)
    })
    return items
  }

  public async getItem(roomUid: string, groupUid: string): Promise<RoomParticipateUser> {
    const _doc = await getDoc(doc(this.participateUsersRef(roomUid), groupUid))
    if (_doc.exists()) {
      return {
        uid: _doc.id,
        ..._doc.data(),
      } as RoomParticipateUser
    } else throw Error
  }

  public async getItemToLoginToken(
    roomUid: string,
    groupUid: string,
    loginToken: string
  ): Promise<RoomParticipateUser> {
    const _doc = await getDoc(doc(this.participateUsersRef(roomUid), groupUid))
    if (_doc.exists() && _doc.data()?.loginToken === loginToken) {
      return {
        uid: _doc.id,
        ..._doc.data(),
      } as RoomParticipateUser
    } else throw Error
  }

  public async setItem(roomUid: string, item: RoomParticipateUser): Promise<void> {
    await setDoc(doc(this.participateUsersRef(roomUid)), {
      ...item,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    })
  }

  public async updateItem(roomUid: string, groupUid: string, item: RoomParticipateUser): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await updateDoc(doc(this.participateUsersRef(roomUid), groupUid), {
      ...item,
      updatedAt: serverTimestamp(),
    })
  }

  public async deleteItem(roomUid: string, groupUid: string): Promise<void> {
    await deleteDoc(doc(this.participateUsersRef(roomUid), groupUid))
  }
}
