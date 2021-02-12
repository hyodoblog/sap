import { GetterTree, MutationTree } from 'vuex'
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
