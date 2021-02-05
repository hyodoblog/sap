import { ActionTree, MutationTree } from 'vuex'
import { Room } from '~/modules/types/models'
import { RoomState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new RoomState())

export const mutations: MutationTree<RoomState> = {
  RESET(state) {
    Object.assign(state, new RoomState())
  },

  SET(state, items: Room[]) {
    state.items = items
  },
}

export const actions: ActionTree<RoomState, RootState> = {
  async init({ commit }) {
    try {
      await this
    } catch {
      this.dispatch('snackbar/error', '部屋情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}
