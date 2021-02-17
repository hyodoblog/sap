import { roomsRef } from '../../config/firebase'
import { RoomGroup, RoomParticipateUser } from '../types/models'

export const firestotreGetGroupItems = async (roomUid: string): Promise<RoomGroup[]> => {
  const items: RoomGroup[] = []
  const docs = await roomsRef.doc(roomUid).collection('groups').get()
  docs.forEach((doc) => {
    if (doc.exists) {
      items.push({ uid: doc.id, ...doc.data() } as RoomGroup)
    }
  })
  return items
}

export const firestotreGetParticipateUserItem = async (roomUid: string): Promise<RoomParticipateUser[]> => {
  const items: RoomParticipateUser[] = []
  const docs = await roomsRef.doc(roomUid).collection('participateUsers').get()
  docs.forEach((doc) => {
    if (doc.exists) {
      items.push({ uid: doc.id, ...doc.data() } as RoomParticipateUser)
    }
  })
  return items
}
