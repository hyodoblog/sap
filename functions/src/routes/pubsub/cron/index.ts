import { functions, getNowAt } from '../../../config/firebase'

const runtimeOpts: functions.RuntimeOptions = {
  timeoutSeconds: 60,
  memory: '128MB',
}

module.exports = functions
  .region('asia-northeast1')
  .runWith(runtimeOpts)
  .pubsub.schedule('*/1 * * * *')
  .timeZone('Asia/Tokyo')
  .onRun(async () => {
    console.log('cron関数実行開始')

    const nowTime = getNowAt().toDate().toTimeString()
    const nowMinutes = Number(nowTime.substring(nowTime.indexOf(':') + 1, nowTime.lastIndexOf(':')))
    console.log(nowMinutes)

    console.log('cron関数実行開始')
  })
