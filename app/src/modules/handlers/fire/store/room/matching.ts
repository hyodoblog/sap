import firebase from 'firebase/app'
import { RoomMatching } from '~/modules/types/models'

export class RoomMatchingDb {
  private roomRef: firebase.firestore.CollectionReference

  constructor(rootRef: firebase.firestore.DocumentReference) {
    this.roomRef = rootRef.collection('rooms')
  }

  private matchingsRef(roomUid: string): firebase.firestore.CollectionReference {
    return this.roomRef.doc(roomUid).collection('matchings')
  }

  public async getItems(roomUid: string): Promise<RoomMatching[]> {
    const items: RoomMatching[] = []
    const docs = await this.matchingsRef(roomUid).get()
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomMatching)
    })
    return items
  }
}
