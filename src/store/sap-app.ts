import { ActionTree, MutationTree } from 'vuex'
import { SapApp } from '~/modules/types/models'
import { SapAppState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new SapAppState())

export const mutations: MutationTree<SapAppState> = {
  RESET(state) {
    Object.assign(state, new SapAppState())
  },

  SET(state, items: SapApp[]) {
    state.items = items
  },
}

export const actions: ActionTree<SapAppState, RootState> = {
  async init({ commit }) {
    try {
      await this
    } catch {
      this.dispatch('snackbar/error', 'SAPアプリ情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}
