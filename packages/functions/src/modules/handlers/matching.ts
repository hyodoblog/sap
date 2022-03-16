import { admin, getServerTimestamp, roomsRef } from '../../config/firebase'

// modules handlers
import { firestoreGetGroupItems, firestoreGetParticipateUserItem } from './firestore'

// modules types
import { Room, RoomGroup, RoomParticipateUser, RoomMatching } from '../types/models'

// ********
// handlers
// ********

// *******
// Step 1

interface HopeItem {
  uid: string
  hopeUidItems: string[]
  displayName?: string
}

interface Rate {
  uid: string
  rate: number
}
// 人数: 5人
// 1位： 50
// 2位: 5
// 3位: 4
// 4位: 3
// 5位: 2
const topAdbansePoint = 10
const getInitRateItems = (
  hopeListItems: HopeItem[],
  items: RoomGroup[] | RoomParticipateUser[],
  maxNum: number
): Rate[] => {
  const rateItems: Rate[] = []
  for (const hopeListItem of hopeListItems) {
    for (let hopeUidItemsIndex = 0; hopeUidItemsIndex < hopeListItem.hopeUidItems.length; hopeUidItemsIndex++) {
      // rateItemsの更新
      for (const item of items) {
        if (item.uid === hopeListItem.hopeUidItems[hopeUidItemsIndex]) {
          let rate: number
          // 一位のみアドバンスポイントを掛ける
          if (hopeUidItemsIndex === 0) {
            rate = maxNum * topAdbansePoint
          } else {
            rate = maxNum - hopeUidItemsIndex
          }
          rateItems.push({
            uid: hopeListItem.hopeUidItems[hopeUidItemsIndex],
            rate,
          })
          break
        }
      }
    }
  }
  return rateItems
}

// *******
// Step 3
// algorithm step1

interface MatchingGroupNum {
  groupUid: string
  num: number
}
const isAddMatchingGroupNumItems = (matchingGroupNumItems: MatchingGroupNum[], groupItems: RoomGroup[]): boolean => {
  let totalMaxNum = 0
  let totalMatchingGroupNum = 0
  for (const matchingGroupNumItem of matchingGroupNumItems) {
    for (const groupItem of groupItems) {
      if (groupItem.uid === matchingGroupNumItem.groupUid) {
        if (groupItem.maxNum === null) return true
        else totalMaxNum += groupItem.maxNum
      }
    }
    totalMatchingGroupNum += matchingGroupNumItem.num
  }
  // null設定がない場合
  if (totalMatchingGroupNum < totalMaxNum) return true
  else return false
}
const algorithmStep1 = (
  groupItems: RoomGroup[],
  groupLength: number,
  participateUserLength: number
): MatchingGroupNum[] => {
  const average = participateUserLength > groupLength ? Math.floor(participateUserLength / groupLength) : 1
  const matchingGroupNumItems: MatchingGroupNum[] = []

  // 平均値をベースに仮割当をする
  const availableGroupItems: RoomGroup[] = []
  let totalMatchingNum = 0
  for (const groupItem of groupItems) {
    // 無制限設定のグループ
    if (groupItem.maxNum === null) {
      totalMatchingNum += average
      matchingGroupNumItems.push({
        groupUid: groupItem.uid as string,
        num: average,
      })
      availableGroupItems.push(groupItem)
    }
    // 平均より最大人数が小さい場合
    else if (groupItem.maxNum <= average) {
      totalMatchingNum += groupItem.maxNum
      matchingGroupNumItems.push({
        groupUid: groupItem.uid as string,
        num: groupItem.maxNum,
      })
    }
    // 大きい場合
    else {
      totalMatchingNum += average
      matchingGroupNumItems.push({
        groupUid: groupItem.uid as string,
        num: average,
      })
      availableGroupItems.push(groupItem)
    }
  }

  let remainParticipateUserNum = participateUserLength - totalMatchingNum
  if (remainParticipateUserNum === 0) {
    return matchingGroupNumItems
  }

  // 最大参加人数の設定ミスによる対策
  if (!isAddMatchingGroupNumItems(matchingGroupNumItems, groupItems)) {
    while (remainParticipateUserNum > 0) {
      for (const matchingGroupNumItem of matchingGroupNumItems) {
        matchingGroupNumItem.num++
        remainParticipateUserNum--
        if (remainParticipateUserNum <= 0) {
          return matchingGroupNumItems
        }
      }
    }
  }

  // 追加可能な
  while (remainParticipateUserNum > 0) {
    for (const availableGroupItem of availableGroupItems) {
      for (const matchingGroupNumItem of matchingGroupNumItems) {
        if (matchingGroupNumItem.groupUid === availableGroupItem.uid) {
          remainParticipateUserNum--
          matchingGroupNumItem.num++
          if (remainParticipateUserNum <= 0) {
            return matchingGroupNumItems
          }
        }
      }
    }
  }

  return matchingGroupNumItems
}

// *******
// Step 4
// algorithm step2

const algorithmStep2 = (matchingGroupNumItems: MatchingGroupNum[]): RoomMatching[] => {
  const items: RoomMatching[] = []
  for (const matchingGroupNumItem of matchingGroupNumItems) {
    const participateUserUidItems: string[] = []
    for (let i = 0; i < matchingGroupNumItem.num; i++) participateUserUidItems.push('')
    items.push({
      groupUid: matchingGroupNumItem.groupUid,
      participateUserUidItems,
    })
  }
  return items
}

// *******
// Step 5
// algorithm step3

// 追加処理関数群
const isParticipateUserToMatchingItems = (matchingItems: RoomMatching[], participateUserUid: string): boolean => {
  for (const matchingItem of matchingItems) {
    for (const participateUserUidItem of matchingItem.participateUserUidItems) {
      if (participateUserUidItem === participateUserUid) return true
    }
  }
  return false
}
const isMatchingItems = (matchingItems: RoomMatching[], groupUid: string): boolean => {
  for (const matchingItem of matchingItems) {
    if (matchingItem.groupUid === groupUid) {
      return matchingItem.participateUserUidItems.some((uid) => !uid)
    }
  }
  return false
}
const addMatchingItems = (
  matchingItems: RoomMatching[],
  groupUid: string,
  participateUserUid: string
): RoomMatching[] => {
  for (const matchingItem of matchingItems) {
    if (matchingItem.groupUid === groupUid) {
      for (let i = 0; i < matchingItem.participateUserUidItems.length; i++) {
        if (!matchingItem.participateUserUidItems[i]) {
          matchingItem.participateUserUidItems[i] = participateUserUid
          return matchingItems
        }
      }
    }
  }
  return matchingItems
}
// conflict時の関数群
interface ExchangeRes {
  exchangeIndex: number
  exchangeParticipateUserUid: string
}
const getParticipateUsersUidIndexToExchange = (
  matchingItems: RoomMatching[],
  groupHopeToParticipateUserUidItems: HopeItem[],
  groupUid: string,
  participateUserUid: string
): ExchangeRes | null => {
  for (const groupHopeToParticipateUserUidItem of groupHopeToParticipateUserUidItems) {
    if (groupHopeToParticipateUserUidItem.uid === groupUid) {
      // ここに処理を書く
      let isExistParticipateUserUidToHope = false
      for (const hopeParticipateUserUid of groupHopeToParticipateUserUidItem.hopeUidItems) {
        // 競合した参加者がマッチングされているグループが希望してない場合
        if (hopeParticipateUserUid === participateUserUid) {
          for (const matchingItem of matchingItems) {
            if (matchingItem.groupUid === groupUid) {
              for (let i = 0; i < matchingItem.participateUserUidItems.length; i++) {
                if (!groupHopeToParticipateUserUidItem.hopeUidItems.includes(matchingItem.participateUserUidItems[i])) {
                  return { exchangeIndex: i, exchangeParticipateUserUid: matchingItem.participateUserUidItems[i] }
                }
              }
            }
          }
          isExistParticipateUserUidToHope = true
          continue
        }

        // 競合した参加者同士が希望されている場合
        while (isExistParticipateUserUidToHope) {
          // 逆から検索
          for (let i = groupHopeToParticipateUserUidItem.hopeUidItems.length - 1; i >= 0; i--) {
            // 競合した参加者の希望が最下位の場合入れ替えない
            if (groupHopeToParticipateUserUidItem.hopeUidItems[i] === participateUserUid) return null

            for (const matchingItem of matchingItems) {
              if (matchingItem.groupUid === groupUid) {
                for (let mI = 0; mI < matchingItem.participateUserUidItems.length; mI++) {
                  if (groupHopeToParticipateUserUidItem.hopeUidItems[i] === matchingItem.participateUserUidItems[mI]) {
                    return { exchangeIndex: mI, exchangeParticipateUserUid: matchingItem.participateUserUidItems[mI] }
                  }
                }
              }
            }
          }

          return null
        }
      }
    }
  }
  return null
}
const exchangeMatchingItems = (
  matchingItems: RoomMatching[],
  afterGroupUid: string,
  changeParticipateUserIndex: number,
  participateUserUid: string
): RoomMatching[] => {
  for (let i = 0; i < matchingItems.length; i++) {
    if (matchingItems[i].groupUid === afterGroupUid) {
      matchingItems[i].participateUserUidItems[changeParticipateUserIndex] = participateUserUid
    }
  }
  return matchingItems
}
const deleteHopeParticipateUser = (
  groupHopeToParticipateUserUidItems: HopeItem[],
  groupUid: string,
  participateUserUid: string
): HopeItem[] => {
  for (let i = 0; i < groupHopeToParticipateUserUidItems.length; i++) {
    if (groupHopeToParticipateUserUidItems[i].uid === groupUid) {
      for (let j = 0; j < groupHopeToParticipateUserUidItems[i].hopeUidItems.length; j++) {
        if (groupHopeToParticipateUserUidItems[i].hopeUidItems[j] === participateUserUid) {
          groupHopeToParticipateUserUidItems[i].hopeUidItems.splice(j, 1)
          return groupHopeToParticipateUserUidItems
        }
      }
    }
  }
  return groupHopeToParticipateUserUidItems
}

const algorithmStep3 = (
  matchingItems: RoomMatching[],
  groupHopeToParticipateUserUidItems: HopeItem[],
  participateUserHopeToGroupUidItems: HopeItem[],
  participateUserUid?: string
): RoomMatching[] => {
  for (const participateUserHopeToGroupUidItem of participateUserHopeToGroupUidItems) {
    // 再帰処理時
    if (participateUserUid) {
      if (participateUserHopeToGroupUidItem.uid !== participateUserUid) continue
    }

    for (const participateUserHopeToGroupUid of participateUserHopeToGroupUidItem.hopeUidItems) {
      // すでにマッチング済みの参加者はスキップ
      if (isParticipateUserToMatchingItems(matchingItems, participateUserHopeToGroupUid)) continue

      // マッチング可能な場合、追加
      if (isMatchingItems(matchingItems, participateUserHopeToGroupUid)) {
        matchingItems = addMatchingItems(
          matchingItems,
          participateUserHopeToGroupUid,
          participateUserHopeToGroupUidItem.uid
        )
        break
      }
      // 競合発生時
      else {
        const exchangeRes = getParticipateUsersUidIndexToExchange(
          matchingItems,
          groupHopeToParticipateUserUidItems,
          participateUserHopeToGroupUid,
          participateUserHopeToGroupUidItem.uid
        )
        // 入れ替わる場合
        if (exchangeRes !== null) {
          matchingItems = exchangeMatchingItems(
            matchingItems,
            participateUserHopeToGroupUid,
            exchangeRes.exchangeIndex,
            participateUserHopeToGroupUidItem.uid
          )
          groupHopeToParticipateUserUidItems = deleteHopeParticipateUser(
            groupHopeToParticipateUserUidItems,
            participateUserHopeToGroupUid,
            exchangeRes.exchangeParticipateUserUid
          )
          matchingItems = algorithmStep3(
            matchingItems,
            groupHopeToParticipateUserUidItems,
            participateUserHopeToGroupUidItems,
            exchangeRes.exchangeParticipateUserUid
          )
          break
        }
      }
    }
  }

  return matchingItems
}

// *******
// Step 7
// algorithm step4
const isParticipateUserUidToMatchingItems = (matchingItems: RoomMatching[], participateUserUid: string): boolean => {
  for (const matchingItem of matchingItems) {
    for (const hopeParticipateUserUid of matchingItem.participateUserUidItems) {
      if (hopeParticipateUserUid === participateUserUid) return true
    }
  }
  return false
}
const addParticipateUserUidToMatchingItems = (
  matchingItems: RoomMatching[],
  participateUserUid: string
): RoomMatching[] => {
  for (let i = 0; i < matchingItems.length; i++) {
    for (let j = 0; j < matchingItems[i].participateUserUidItems.length; j++) {
      if (!matchingItems[i].participateUserUidItems[j]) {
        matchingItems[i].participateUserUidItems[j] = participateUserUid
        return matchingItems
      }
    }
  }
  return matchingItems
}
const algorithmStep4 = (matchingItems: RoomMatching[], participateUserItems: RoomParticipateUser[]): RoomMatching[] => {
  // 未マッチングの参加者を整理
  const remainParticipateUserUidItems: string[] = []
  for (const participateUserItem of participateUserItems) {
    if (!isParticipateUserUidToMatchingItems(matchingItems, participateUserItem.uid as string))
      remainParticipateUserUidItems.push(participateUserItem.uid as string)
  }

  for (const remainParticipateUserUid of remainParticipateUserUidItems)
    addParticipateUserUidToMatchingItems(matchingItems, remainParticipateUserUid)

  return matchingItems
}

// **********
// Storeに保存

const deleteAllRoomMatchingItems = async (matchingsRef: admin.firestore.CollectionReference): Promise<void> => {
  const uidItems: string[] = []
  const docs = await matchingsRef.get()
  docs.forEach((doc) => {
    if (doc.exists) uidItems.push(doc.id)
  })
  await Promise.all(uidItems.map((uid) => matchingsRef.doc(uid).delete()))
}
const setRoomMatchingItems = async (roomUid: string, matchingItems: RoomMatching[]): Promise<void> => {
  const matchingsRef = roomsRef.doc(roomUid).collection('matchings')
  await deleteAllRoomMatchingItems(matchingsRef)
  await Promise.all(
    matchingItems.map((item) =>
      matchingsRef
        .doc()
        .set({ ...item, createdAt: getServerTimestamp(), updatedAt: getServerTimestamp() } as RoomMatching)
    )
  )
}

// ********
// main関数
// ********
export default (roomItems: Room[]) =>
  Promise.all(
    roomItems.map(async (roomItem) => {
      // group変数の初期化
      const groupItems = await firestoreGetGroupItems(roomItem.uid as string)
      const groupHopeToParticipateUserUidItems: HopeItem[] = groupItems.map((item) => {
        return {
          uid: item.uid as string,
          hopeUidItems: item.hopeParticipateUserUidItems,
          displayName: item.displayName,
        }
      })
      const groupLength = groupItems.length
      const groupRateMaxNum = roomItem.groupHopeMaxNum || groupLength
      // participate user変数の初期化
      const participateUserItems = await firestoreGetParticipateUserItem(roomItem.uid as string)
      const participateUserHopeToGroupUidItems: HopeItem[] = participateUserItems.map((item) => {
        return { uid: item.uid as string, hopeUidItems: item.hopeGroupUidItems, displayName: item.displayName }
      })
      const participateUserLength = participateUserItems.length
      const participateUserRateMaxNum = roomItem.participateUserHopeMaxNum || participateUserLength

      // ----------------------
      // --- アルゴリズムの実装 ---

      // Step 1
      // レート更新
      const groupRateItems = getInitRateItems(participateUserHopeToGroupUidItems, groupItems, groupRateMaxNum)
      // const participateUserRateItems = getInitRateItems(
      //   groupHopeToParticipateUserUidItems,
      //   participateUserItems,
      //   participateUserRateMaxNum
      // )

      // // Step 2
      // // グループをレート順にソート
      groupRateItems.sort(function (a, b) {
        if (a.rate < b.rate) return 1
        else return -1
      })

      groupItems.sort(function (a, b) {
        const aGroupRateItem = groupRateItems.filter((item) => item.uid === a.uid)[0]
        const bGroupRateItem = groupRateItems.filter((item) => item.uid === b.uid)[0]
        if (!aGroupRateItem || !bGroupRateItem) throw new Error('group rate item is not found.')

        if (aGroupRateItem.rate < bGroupRateItem.rate) return 1
        else return -1
      })

      // Step 3
      // Algorithm Step 1
      // グループマッチングの人数を整理
      const matchingGroupNumItems = algorithmStep1(groupItems, groupLength, participateUserLength)

      // Step 4
      // Algorithm Step 2
      // すべての参加者を未マッチングにする
      let matchingItems = algorithmStep2(matchingGroupNumItems)

      // Step 5
      // Algorithm Step 3
      // 希望を提出した参加者のマッチング処理

      matchingItems = algorithmStep3(
        matchingItems,
        groupHopeToParticipateUserUidItems,
        participateUserHopeToGroupUidItems
      )

      // Step 6
      // マッチング度が高い参加者を確定処理する

      // Step 7
      // マッチングされてない参加者をランダムでマッチングする
      matchingItems = algorithmStep4(matchingItems, participateUserItems)

      // --- アルゴリズムの終了 ---
      // ----------------------

      // storeに保存
      await setRoomMatchingItems(roomItem.uid as string, matchingItems)
    })
  ).catch((err) => {
    console.log(err)
    throw new Error(err)
  })
