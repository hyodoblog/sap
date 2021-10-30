import { admin, roomsRef, usersRef } from '../../config/firebase'
import { Room, RoomGroup, RoomParticipateUser, User } from '../../../modules/types/models'
import { getServerTimestamp } from './firebase'

// *******************
// Timestamp

export const timestampConvertDatetimeJp = (at: admin.firestore.Timestamp): string => {
  const date = at.toDate()
  return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日 ${('0' + date.getHours()).slice(-2)}時${(
    '0' + date.getMinutes()
  ).slice(-2)}分`
}

// *******************
// /users

export const firestoreGetUser = async (uid: string): Promise<User | null> => {
  const doc = await usersRef.doc(uid).get()
  if (doc.exists) {
    return doc.data() as User
  } else return null
}

export const firestoreInitUser = async (uid: string, email: string): Promise<void> => {
  const item = { email } as User
  await usersRef.doc(uid).set({ ...item, createdAt: getServerTimestamp(), updatedAt: getServerTimestamp() } as User)
}

export const firestoreUpdateUser = async (uid: string, item: User): Promise<void> => {
  delete item.uid
  delete item.updatedAt
  await usersRef.doc(uid).update({ ...item, updatedAt: getServerTimestamp() } as User)
}

// *******************
// /rooms

export const firestoreGetRoom = async (uid: string): Promise<Room> => {
  const doc = await roomsRef.doc(uid).get()
  if (doc.exists) {
    return {
      uid: doc.id,
      ...doc.data(),
    } as Room
  } else throw new Error('firestoreGetRoomでデータが取得できませんでした。')
}

export const firestoreSetRoom = async (uid: string, item: Room): Promise<void> => {
  await roomsRef.doc(uid).set({
    ...item,
    createdAt: getServerTimestamp(),
    updatedAt: getServerTimestamp(),
  } as Room)
}

export const firestoreUpdateRoom = async (uid: string, item: Room): Promise<void> => {
  delete item.uid
  delete item.createdAt
  delete item.updatedAt
  await roomsRef.doc(uid).update({
    ...item,
    updatedAt: getServerTimestamp(),
  } as Room)
}

// /rooms/groups

export const firestoreGetGroupItem = async (roomUid: string, groupUid: string): Promise<RoomGroup> => {
  const doc = await roomsRef.doc(roomUid).collection('groups').doc(groupUid).get()
  if (doc.exists) {
    return { uid: doc.id, ...doc.data() } as RoomGroup
  } else throw new Error('firestoreGetGroupItem not found.')
}

export const firestoreGetIsEmailGroups = async (roomUid: string): Promise<RoomGroup[]> => {
  const docs = await roomsRef.doc(roomUid).collection('groups').where('email', '!=', 'null').get()
  const items: RoomGroup[] = []
  docs.forEach((doc) => {
    if (doc.exists) {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomGroup)
    }
  })
  return items
}

// /rooms/participateUsers

export const firestoreGetParticipateUserItem = async (
  roomUid: string,
  participateUserUid: string
): Promise<RoomParticipateUser> => {
  const doc = await roomsRef.doc(roomUid).collection('participateUsers').doc(participateUserUid).get()
  if (doc.exists) {
    return { uid: doc.id, ...doc.data() } as RoomParticipateUser
  } else throw new Error('firestoreGetParticipateUserItem not found.')
}

export const firestoreGetIsEmailParticipateUsers = async (roomUid: string): Promise<RoomParticipateUser[]> => {
  const docs = await roomsRef.doc(roomUid).collection('participateUsers').where('email', '!=', 'null').get()
  const items: RoomParticipateUser[] = []
  docs.forEach((doc) => {
    if (doc.exists) {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as RoomParticipateUser)
    }
  })
  return items
}
