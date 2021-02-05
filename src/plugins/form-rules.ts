import RoomFormRule from '~/modules/handlers/form-rules/room'

export interface FormRulesApi {
  room: RoomFormRule
}

export default function (_: any, inject: (arg0: string, arg1: FormRulesApi) => void) {
  const formRules: FormRulesApi = {
    room: new RoomFormRule(),
  }

  inject('formRules', formRules)
}
