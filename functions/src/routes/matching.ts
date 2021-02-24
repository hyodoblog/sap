import { functions, roomsRef } from '../config/firebase'

// modules handlers
import matchingHandlers from '../modules/handlers/handlers'

// modules types
import { Room } from '../modules/types/models'

// ********
// handlers
// ********

const getRoomItem = async (roomUid: string): Promise<Room> => {
  const doc = await roomsRef.doc(roomUid).get()
  if (doc.exists) {
    return {
      uid: doc.id,
      ...doc.data(),
    } as Room
  } else throw Error('room not found.')
}

// ********
// main関数
// ********
async function main(data: any, context: functions.https.CallableContext) {
  console.log('matching関数実行開始')

  try {
    console.log(data)
    console.log(context)
    if (!context.auth?.uid) throw new Error('not Auth')
    const roomUid = data.roomUid
    if (!roomUid) throw new Error('request body is not.')

    // 稼働中のroomの取得
    const roomItem = await getRoomItem(roomUid)

    // matching
    await matchingHandlers([roomItem])
    console.log('matching関数実行成功')
  } catch (err) {
    console.log('matching関数実行エラー')
    console.error(err)
    throw Error
  }

  console.log('matching関数実行終了')
}

// *************
// functions設定
// *************
const runtimeOpts: functions.RuntimeOptions = {
  timeoutSeconds: 540,
  memory: '256MB',
}

module.exports = module.exports = functions
  .region('asia-northeast1')
  .runWith(runtimeOpts)
  .https.onCall((data, context) => main(data, context))
