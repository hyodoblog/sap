import { ActionTree, GetterTree, MutationTree } from 'vuex'
import { User } from '~/modules/types/models'
import { AuthState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new AuthState())

export const getters: GetterTree<AuthState, RootState> = {
  isAuthenticated: (state) => !!state.userUid && !!state.user,
}

export const mutations: MutationTree<AuthState> = {
  RESET(state) {
    Object.assign(state, new AuthState())
  },

  SET_USER(state, user: User) {
    state.user = user
  },

  SET_USER_UID(state, userUid: string) {
    state.userUid = userUid
  },
}

export const actions: ActionTree<AuthState, RootState> = {}
