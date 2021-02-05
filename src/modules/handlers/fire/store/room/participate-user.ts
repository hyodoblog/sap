import firebase from 'firebase/app'
import { RoomParticipateUser } from '~/modules/types/models'

export class RoomParticipateUserDb {
  private roomsRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.roomsRef = db.collection('rooms')
  }

  private participateUsersRef(roomUid: string): firebase.firestore.CollectionReference {
    return this.roomsRef.doc(roomUid).collection('participateUsers')
  }

  public async getItems(roomUid: string): Promise<RoomParticipateUser[]> {
    const items: RoomParticipateUser[] = []
    const docs = await this.participateUsersRef(roomUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomParticipateUser)
    })
    return items
  }

  public async getItem(roomUid: string, groupUid: string): Promise<RoomParticipateUser | null> {
    const doc = await this.participateUsersRef(roomUid).doc(groupUid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as RoomParticipateUser
    } else {
      return null
    }
  }

  public async setItem(roomUid: string, item: RoomParticipateUser): Promise<void> {
    await this.participateUsersRef(roomUid)
      .doc()
      .set({
        ...item,
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      })
  }

  public async updateItem(roomUid: string, groupUid: string, item: RoomParticipateUser): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.participateUsersRef(roomUid)
      .doc(groupUid)
      .update({
        ...item,
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      } as RoomParticipateUser)
  }

  public async deleteItem(roomUid: string, groupUid: string): Promise<void> {
    await this.participateUsersRef(roomUid).doc(groupUid).delete()
  }
}
