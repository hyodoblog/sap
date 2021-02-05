import { Request, Response } from 'express'
import { admin } from '../../../config/firebase'

// 型モジュール
import { ApiVerifyCookieReqParams, ApiVerifyCookieResParams } from '../../../../modules/types/api'
import { firestoreGetUser } from '~/server/modules/handlers/firestore'

const isRequestBody = (data: any): data is ApiVerifyCookieReqParams =>
  data !== null && typeof data.sessionCookie === 'string'

export default async (req: Request, res: Response) => {
  try {
    const data = req.body
    if (!isRequestBody(data)) throw new Error('Reqest Body is not match')

    const { sessionCookie, userUid } = data

    await admin.auth().verifySessionCookie(sessionCookie, true)
    const user = await firestoreGetUser(userUid)
    if (user === null) throw new Error('ユーザー情報が見つかりませんでした。')

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
