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

export const actions: ActionTree<AuthState, RootState> = {
  async init({ commit }, { uid, nickname }) {
    try {
      const user = await this.$fire.store.user.getItem(uid)
      if (user) {
        commit('SET_USER', user)
        commit('SET_USER_UID', uid)
      } else {
        const user = await this.$fire.store.user.setInit(uid, nickname)
        commit('SET_USER', user)
        commit('SET_USER_UID', uid)
      }
    } catch {
      this.dispatch('snackbar/error', 'ユーザー情報の初期化に失敗しました。')
    }
  },
}
