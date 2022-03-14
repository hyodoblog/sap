// modules handlers
import { converTimestamp, firebaseVerifyIdToken } from '../../../modules/handlers/firebase'
import { firestoreSetRoom } from '../../../modules/handlers/firestore'

// 型モジュール
import { ApiCreateRoomReqParams } from '../../../../modules/types/api'

const isRequestBody = (data: any): data is ApiCreateRoomReqParams =>
  data !== null && typeof data.roomUid === 'string' && data.roomItem !== null

export default async (req: any, res: any) => {
  try {
    const data = req.body
    if (!isRequestBody(data)) throw new Error('Reqest Body is not match')
    const decodedIdToken = await firebaseVerifyIdToken(req)
    if (!decodedIdToken.uid) throw new Error('Not Permission Error.')

    const { roomUid, roomItem } = data
    roomItem.startAt = converTimestamp(roomItem.startAt.seconds)
    roomItem.votingEndAt = converTimestamp(roomItem.votingEndAt.seconds)
    roomItem.browsingEndAt = converTimestamp(roomItem.browsingEndAt.seconds)
    await firestoreSetRoom(roomUid, roomItem)

    res.status(200).end()
  } catch (err) {
    console.error('adminCreateRoom関数でエラーが発生しました。')
    console.error(err)
    res.status(500).end()
  }
}
