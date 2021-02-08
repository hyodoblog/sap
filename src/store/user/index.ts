import { ActionTree, GetterTree, MutationTree } from 'vuex'
import { User } from '~/modules/types/models'
import { UserState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new UserState())

export const getters: GetterTree<UserState, RootState> = {
  isAuthenticated: (state) => !!state.uid && !!state.item,
}

export const mutations: MutationTree<UserState> = {
  RESET(state) {
    Object.assign(state, new UserState())
  },

  SET_ITEM(state, item: User) {
    state.item = item
  },

  SET_UID(state, uid: string) {
    state.uid = uid
  },
}

export const actions: ActionTree<UserState, RootState> = {
  async init({ commit }, { uid, nickname, email }) {
    try {
      const item = await this.$fire.store.user.getItem(uid)
      if (item) {
        commit('SET_ITEM', item)
        commit('SET_UID', uid)
      } else {
        const item = await this.$fire.store.user.setInit(uid, nickname, email)
        commit('SET_ITEM', item)
        commit('SET_UID', uid)
      }
    } catch {
      this.dispatch('snackbar/error', 'ユーザー情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}
