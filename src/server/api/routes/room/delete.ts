import { Request, Response } from 'express'
import { db, roomsRef } from '../../../config/firebase'

// modules handlers
import { firebaseVerifyIdToken } from '../../../modules/handlers/firebase'
import { storageDeleteItem } from '../../../modules/handlers/storage'

// 型モジュール
import { ApiDeleteRoomReqParams } from '../../../../modules/types/api'

const isRequestBody = (data: any): data is ApiDeleteRoomReqParams => data !== null && typeof data.roomUid === 'string'

const deleteProcess = (roomUid: string) =>
  db.runTransaction(async (t) => {
    // データを取得
    const roomRef = roomsRef.doc(roomUid)

    // iconPathの取得
    const roomDoc = await t.get(roomRef)
    if (!roomDoc.exists) throw new Error('部屋情報が見つかりませんでした。')
    const iconPath = roomDoc.data()?.iconPath

    // /rooms/groupsを取得
    const roomGorupUidItems: string[] = []
    const roomGroupsRef = roomRef.collection('groups')
    const roomGroupsDoc = await t.get(roomGroupsRef)
    roomGroupsDoc.forEach((doc) => {
      if (doc.exists) {
        roomGorupUidItems.push(doc.id)
      }
    })

    // /rooms/participateUsersを取得
    const roomParticipateUserUidItems: string[] = []
    const roomParticipateUsersRef = roomRef.collection('participateUsers')
    const roomParticipateUsersDoc = await t.get(roomParticipateUsersRef)
    roomParticipateUsersDoc.forEach((doc) => {
      if (doc.exists) {
        roomParticipateUserUidItems.push(doc.id)
      }
    })

    // /rooms/messagesを取得
    const roomMessageUidItems: string[] = []
    const roomMessagesRef = roomRef.collection('messages')
    const roomMessagesDoc = await t.get(roomMessagesRef)
    roomMessagesDoc.forEach((doc) => {
      if (doc.exists) {
        roomMessageUidItems.push(doc.id)
      }
    })

    // 画像の削除
    if (iconPath) {
      await storageDeleteItem(iconPath)
    }

    // データの削除
    roomGorupUidItems.forEach((uid) => t.delete(roomGroupsRef.doc(uid)))
    roomParticipateUserUidItems.forEach((uid) => t.delete(roomParticipateUsersRef.doc(uid)))
    roomMessageUidItems.forEach((uid) => t.delete(roomMessagesRef.doc(uid)))
    t.delete(roomRef)
  })

export default async (req: Request, res: Response) => {
  try {
    const data = req.query
    if (!isRequestBody(data)) throw new Error('Reqest Body is not match')
    const decodedIdToken = await firebaseVerifyIdToken(req)
    if (!decodedIdToken.uid) throw new Error('Not Permission Error.')

    const { roomUid } = data

    await deleteProcess(roomUid)

    res.status(200).end()
  } catch (err) {
    console.error('adminDeleteRoom関数でエラーが発生しました。')
    console.error(err)
    res.status(500).end()
  }
}
