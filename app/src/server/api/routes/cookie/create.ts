import { Request, Response } from 'express'
import { admin } from '../../../config/firebase'
import { firebaseVerifyIdToken } from '../../../modules/handlers/firebase'

// 型モジュール
import { ApiCreateCookieReqParams, ApiCreateCookieResParams } from '../../../../modules/types/api'

const isRequestBody = (data: any): data is ApiCreateCookieReqParams => data !== null && typeof data.token === 'string'

export default async (req: Request, res: Response) => {
  try {
    const data = req.body
    if (!isRequestBody(data)) throw new Error('Reqest Body is not match')
    const decodedIdToken = await firebaseVerifyIdToken(req)
    if (!decodedIdToken.uid) throw new Error('Not Permission Error.')

    const expiresIn = 60 * 60 * 24 * 7 * 1000 // 1週間
    const token = await admin.auth().createSessionCookie(data.token, { expiresIn })

    res
      .json({
        token,
      } as ApiCreateCookieResParams)
      .end()
  } catch (err) {
    console.error('adminCreateCookie関数でエラーが発生しました。')
    console.error(err)
    res.status(500).end()
  }
}
