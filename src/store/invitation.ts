import { ActionTree, GetterTree, MutationTree } from 'vuex'
import { RoomGroup, RoomInvitationType, RoomParticipateUser } from '~/modules/types/models'
import { InvitationState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new InvitationState())

export const getters: GetterTree<InvitationState, RootState> = {
  isAuthenticated: (state) =>
    !!state.type && !!state.authItem && !!state.roomItem && !!state.roomGroupItems && !!state.roomParticipateUserItems,
}

export const mutations: MutationTree<InvitationState> = {
  RESET(state) {
    Object.assign(state, new InvitationState())
  },

  SET_ROOM_ITEMS(state, params: InvitationState) {
    state.roomItem = params.roomItem
    state.roomGroupItems = params.roomGroupItems
    state.roomParticipateUserItems = params.roomParticipateUserItems
  },

  SET_AUTH_ITEM(state, params: InvitationState) {
    state.type = params.type
    state.authItem = params.authItem
  },
}

export const actions: ActionTree<InvitationState, RootState> = {
  async initRoom({ commit }, roomUid: string) {
    const roomItem = await this.$fire.store.room.getItem(roomUid as string)
    const roomGroupItems = await this.$fire.store.roomGroup.getItems(roomUid)
    const roomParticipateUserItems = await this.$fire.store.roomParticipateUser.getItems(roomUid)
    commit('SET_ROOM_ITEMS', {
      roomItem,
      roomGroupItems,
      roomParticipateUserItems,
    } as InvitationState)
  },

  async resetAuthItem({ commit, state }, type: RoomInvitationType) {
    try {
      const roomUid = state.roomItem?.uid as string
      switch (type) {
        case 'group': {
          const groupUid = state.authItem?.uid as string
          const groupItem = await this.$fire.store.roomGroup.getItem(roomUid, groupUid)
          commit('SET_AUTH_ITEM', { type, authItem: groupItem } as InvitationState)
          break
        }
        case 'participateUser': {
          const participateUserUid = state.authItem?.uid as string
          const participateUserItem = await this.$fire.store.roomParticipateUser.getItem(roomUid, participateUserUid)
          commit('SET_AUTH_ITEM', { type, authItem: participateUserItem } as InvitationState)
          break
        }
      }
    } catch {
      this.dispatch('snackbar/error', 'グループの初期化に失敗しました。')
    }
  },
}
