import RoomFormRule from '~/modules/handlers/form-rules/room/index'
import RoomGroupFormRule from '~/modules/handlers/form-rules/room/group'
import RoomParticipateUserFormRule from '~/modules/handlers/form-rules/room/participate-user'

export interface FormRulesApi {
  room: RoomFormRule
  roomGroup: RoomGroupFormRule
  roomPaticipateUser: RoomParticipateUserFormRule
}

export default function (_: any, inject: (arg0: string, arg1: FormRulesApi) => void) {
  const formRules: FormRulesApi = {
    room: new RoomFormRule(),
    roomGroup: new RoomGroupFormRule(),
    roomPaticipateUser: new RoomParticipateUserFormRule(),
  }

  inject('formRules', formRules)
}
