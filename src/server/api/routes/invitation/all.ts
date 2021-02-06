import { Request, Response } from 'express'

// config
import { envSendGrid } from '../../../config/env'
import sgMail from '../../../config/sendgrid'

// modules handlers
import { firebaseVerifyIdToken } from '../../../modules/handlers/firebase'
import {
  timestampConvertDatetimeJp,
  firestoreGetRoom,
  firestotreGetIsEmailGroups,
  firestotreGetIsEmailParticipateUsers,
} from '../../../modules/handlers/firestore'
import { utilsGetInvitationLoginLink } from '../../../modules/handlers/utils'

// 型モジュール
import { ApiAllInvitationReqParams } from '../../../../modules/types/api'

const isRequestBody = (data: any): data is ApiAllInvitationReqParams =>
  data !== null && typeof data.roomUid === 'string'

interface dynamicTemplateParams {
  email: string
  userName: string
  roomName: string
  loginUrl: string
  startDatetime: string
  votingEndDatetime: string
  browsingEndDatetime: string
}
const getSendUserItems = async (roomUid: string): Promise<dynamicTemplateParams[]> => {
  const sendUserItems: dynamicTemplateParams[] = []

  // データの取得
  const roomItem = await firestoreGetRoom(roomUid)
  const groupItems = await firestotreGetIsEmailGroups(roomUid)
  const participateUserItems = await firestotreGetIsEmailParticipateUsers(roomUid)

  // データの整形
  groupItems.forEach((item) => {
    sendUserItems.push({
      email: item.email as string,
      userName: item.displayName,
      roomName: roomItem.name,
      startDatetime: timestampConvertDatetimeJp(roomItem.startAt),
      votingEndDatetime: timestampConvertDatetimeJp(roomItem.votingEndAt),
      browsingEndDatetime: timestampConvertDatetimeJp(roomItem.browsingEndAt),
      loginUrl: utilsGetInvitationLoginLink({
        roomUid: roomItem.uid as string,
        type: 'group',
        groupUid: item.uid,
        loginToken: item.loginToken,
      }),
    })
  })
  participateUserItems.forEach((item) => {
    sendUserItems.push({
      email: item.email as string,
      userName: item.displayName,
      roomName: roomItem.name,
      startDatetime: timestampConvertDatetimeJp(roomItem.startAt),
      votingEndDatetime: timestampConvertDatetimeJp(roomItem.votingEndAt),
      browsingEndDatetime: timestampConvertDatetimeJp(roomItem.browsingEndAt),
      loginUrl: utilsGetInvitationLoginLink({
        roomUid: roomItem.uid as string,
        type: 'participateUser',
        participateUserUid: item.uid,
        loginToken: item.loginToken,
      }),
    })
  })

  return sendUserItems
}

const sendMail = (templateId: string, sendUserItems: dynamicTemplateParams[]): Promise<any> =>
  Promise.all(
    sendUserItems.map((item) =>
      sgMail.send({
        to: item.email,
        from: envSendGrid.fromEmail,
        templateId,
        dynamicTemplateData: item,
      })
    )
  )

export default async (req: Request, res: Response) => {
  try {
    const data = req.body
    if (!isRequestBody(data)) throw new Error('Reqest Body is not match')
    const decodedIdToken = await firebaseVerifyIdToken(req)
    if (!decodedIdToken.uid) throw new Error('Not Permission Error.')

    const { roomUid } = data
    const templateId = envSendGrid.templateId.invitation

    const sendUserItems = await getSendUserItems(roomUid)
    await sendMail(templateId, sendUserItems)

    res.status(200).end()
  } catch (err) {
    console.error('invitationAll関数でエラーが発生しました。')
    console.error(err)
    res.status(500).end()
  }
}
