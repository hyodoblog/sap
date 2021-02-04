import { ActionTree, MutationTree } from 'vuex'
import { App } from '~/modules/types/models'
import { AppState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new AppState())

export const mutations: MutationTree<AppState> = {
  RESET(state) {
    Object.assign(state, new AppState())
  },

  SET(state, items: App[]) {
    state.items = items
  },
}

export const actions: ActionTree<AppState, RootState> = {
  async init({ commit }) {
    try {
      await this
    } catch {
      this.dispatch('snackbar/error', 'アプリ情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}
