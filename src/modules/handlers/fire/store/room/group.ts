import firebase from 'firebase/app'
import { RoomGroup } from '~/modules/types/models'

export class RoomGroupDb {
  private roomRef: firebase.firestore.CollectionReference

  constructor(db: firebase.firestore.Firestore) {
    this.roomRef = db.collection('rooms')
  }

  private groupsRef(roomUid: string): firebase.firestore.CollectionReference {
    return this.roomRef.doc(roomUid).collection('groups')
  }

  public async getItems(roomUid: string): Promise<RoomGroup[]> {
    const items: RoomGroup[] = []
    const docs = await this.groupsRef(roomUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomGroup)
    })
    return items
  }

  public async getItem(roomUid: string, groupUid: string): Promise<RoomGroup | null> {
    const doc = await this.groupsRef(roomUid).doc(groupUid).get()
    if (doc.exists) {
      return {
        uid: doc.id,
        ...doc.data(),
      } as RoomGroup
    } else {
      return null
    }
  }

  public async setItem(roomUid: string, item: RoomGroup): Promise<void> {
    await this.groupsRef(roomUid)
      .doc()
      .set({
        ...item,
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      })
  }

  public async updateItem(roomUid: string, groupUid: string, item: RoomGroup): Promise<void> {
    delete item.uid
    delete item.createdAt
    delete item.updatedAt
    await this.groupsRef(roomUid)
      .doc(groupUid)
      .update({
        ...item,
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
      } as RoomGroup)
  }

  public async deleteItem(roomUid: string, groupUid: string): Promise<void> {
    await this.groupsRef(roomUid).doc(groupUid).delete()
  }
}
