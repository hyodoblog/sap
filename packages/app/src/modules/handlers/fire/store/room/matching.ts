import { collection, CollectionReference, DocumentReference, getDocs } from 'firebase/firestore'
import { RoomMatching } from '~/modules/types/models'

export class RoomMatchingDb {
  private roomRef: CollectionReference

  constructor(rootRef: DocumentReference) {
    this.roomRef = collection(rootRef, 'rooms')
  }

  private matchingsRef(roomUid: string): CollectionReference {
    return collection(this.roomRef, roomUid, 'matchings')
  }

  public async getItems(roomUid: string): Promise<RoomMatching[]> {
    const items: RoomMatching[] = []
    const docs = await getDocs(this.matchingsRef(roomUid))
    docs.forEach((doc) => {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomMatching)
    })
    return items
  }
}
