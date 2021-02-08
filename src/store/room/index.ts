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
      const userUid = this.state.user?.uid as string
      const items = await this.$fire.store.room.getItems(userUid)
      commit('SET', items)
    } catch (err) {
      console.log(err)
      this.dispatch('snackbar/error', '部屋情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}
