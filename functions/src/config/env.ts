import { functions } from './firebase'

export const storeEnv = functions.config().store.env as string
export const serviceAccountId = functions.config().gcp.service.account.id as string

if (!storeEnv || !serviceAccountId) {
  throw new Error('Not Set Env Variables. ')
}
