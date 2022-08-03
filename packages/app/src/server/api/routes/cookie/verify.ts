import { auth } from '../../../config/firebase'

// modules handlers
import { firestoreGetUser, firestoreInitUser } from '../../../modules/handlers/firestore'

// 型モジュール
import { ApiVerifyCookieReqParams, ApiVerifyCookieResParams } from '../../../../modules/types/api'

const isRequestBody = (data: any): data is ApiVerifyCookieReqParams =>
  data !== null && typeof data.sessionCookie === 'string' && typeof data.email === 'string'

export default async (req: any, res: any) => {
  try {
    const data = req.body
    if (!isRequestBody(data)) throw new Error('Reqest Body is not match')

    const { sessionCookie, userUid, email } = data

    await auth.verifySessionCookie(sessionCookie, true)
    const user = await firestoreGetUser(userUid)
    if (user === null) await firestoreInitUser(userUid, email)

    res
      .json({
        user,
      } as ApiVerifyCookieResParams)
      .status(200)
      .end()
  } catch (err) {
    console.error('adminVerifyCookie関数でエラーが発生しました。')
    console.error(err)
    res.status(500).end()
  }
}
