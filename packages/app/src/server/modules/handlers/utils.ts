import { baseUrl } from '../../config/env'
import { RoomInvitationType } from '../../../modules/types/models'

interface InvitationParams {
  roomUid: string
  type: RoomInvitationType
  groupUid?: string
  participateUserUid?: string
  loginToken: string
}
export const utilsGetInvitationLoginLink = (params: InvitationParams) => {
  switch (params.type) {
    case 'group':
      if (!params.groupUid) throw new Error('utilsGetInvitationLoginLinkでgroupUidが見つかりませんでした。')
      return `${baseUrl}/rooms/${params.roomUid}/voting?roomInvitationType=${params.type}&roomGroupUid=${params.groupUid}&roomUid=${params.roomUid}&loginToken=${params.loginToken}`
    case 'participateUser':
      if (!params.participateUserUid)
        throw new Error('utilsGetInvitationLoginLinkでparticipateUserUidが見つかりませんでした。')
      return `${baseUrl}/rooms/${params.roomUid}/voting?roomInvitationType=${params.type}&roomParticipateUserUid=${params.participateUserUid}&roomUid=${params.roomUid}&loginToken=${params.loginToken}`
  }
}
