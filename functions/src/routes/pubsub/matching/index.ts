import { admin, functions, getNowAt, roomsRef } from '../../../config/firebase'

// modules handlers
import matchingHandlers from './handlers'

// modules types
import { Room } from '../../../modules/types/models'

// ********
// handlers
// ********

const getRoomItems = async (nowAt: admin.firestore.Timestamp): Promise<Room[]> => {
  const items: Room[] = []
  const docs = await roomsRef.where('votingEndAt', '>', nowAt).get()
  docs.forEach((doc) => {
    if (doc.exists) {
      items.push({
        uid: doc.id,
        ...doc.data(),
      } as Room)
    }
  })
  return items
}

// ********
// main関数
// ********
async function main() {
  console.log('pubsubMatching関数実行開始')

  try {
    const nowAt = getNowAt()

    // 稼働中のroomの取得
    const roomItems = await getRoomItems(nowAt)

    // matching
    await matchingHandlers(roomItems)
  } catch (err) {
    console.log('pubsubMatching関数実行でエラーが発生しました。')
    console.error(err)
  }

  console.log('pubsubMatching関数実行終了')
}

// *************
// functions設定
// *************
// 本番
const runtimeOpts: functions.RuntimeOptions = {
  timeoutSeconds: 540,
  memory: '512MB',
}

// emulator
if (process.env.FUNCTIONS_EMULATOR === 'true') {
  module.exports = module.exports = functions
    .region('asia-northeast1')
    .runWith(runtimeOpts)
    .https.onRequest((_, res) => {
      main().finally(() => res.status(200).end())
    })
}
// 本番 pubsub
else {
  module.exports = functions
    .region('asia-northeast1')
    .runWith(runtimeOpts)
    .pubsub.schedule('*/10 * * * *')
    .timeZone('Asia/Tokyo')
    .onRun(main)
}
