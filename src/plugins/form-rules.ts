import SapAppFormRule from '~/modules/handlers/form-rules/sap-app'

export interface FormRulesApi {
  sapApp: SapAppFormRule
}

export default function (_: any, inject: (arg0: string, arg1: FormRulesApi) => void) {
  const formRules: FormRulesApi = {
    sapApp: new SapAppFormRule(),
  }

  inject('formRules', formRules)
}
