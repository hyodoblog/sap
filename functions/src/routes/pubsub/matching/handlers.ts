// modules handlers
import { firestotreGetGroupItems, firestotreGetParticipateUserItem } from '../../../modules/handlers/firestore'

// modules types
import { Room, RoomGroup, RoomParticipateUser } from '../../../modules/types/models'

// ********
// handlers
// ********

// *******
// Step 1

interface HopeItem {
  uid: string
  hopeUidItems: string[]
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
const getInitRateItems = (hopeListItems: HopeItem[], items: RoomGroup[] | RoomParticipateUser[], maxNum: number): Rate[] => {
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
            rate = (maxNum - hopeUidItemsIndex)
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
const algorithmStep1 = (groupItems: RoomGroup[], groupLength: number, participateUserLength: number): MatchingGroupNum[] => {
  const averate = participateUserLength > groupLength ? Math.floor(participateUserLength / groupLength) : 1
  const matchingGroupNumItems: MatchingGroupNum[] = []

  // 平均値をベースに仮割当をする
  let availableGroupItems: RoomGroup[] = []
  let totalMatchingNum = 0
  for (const groupItem of groupItems) {
    if (groupItem.maxNum === null) {
      totalMatchingNum += averate
      matchingGroupNumItems.push({
        groupUid: groupItem.uid as string,
        num: averate,
      })
    } else if (groupItem.maxNum <= averate) {
      totalMatchingNum += groupItem.maxNum
      matchingGroupNumItems.push({
        groupUid: groupItem.uid as string,
        num: groupItem.maxNum,
      })
    } else {
      totalMatchingNum += averate
      matchingGroupNumItems.push({
        groupUid: groupItem.uid as string,
        num: averate,
      })
      availableGroupItems.push(groupItem)
    }
  }

  let remainParticipateUserNum = participateUserLength - totalMatchingNum
  if (remainParticipateUserNum === 0 && availableGroupItems.length === 0) {
    return matchingGroupNumItems
  }

  // 追加可能な
  while (remainParticipateUserNum > 0) {
    // 最大参加人数の設定ミスによる対策
    if (!isAddMatchingGroupNumItems(matchingGroupNumItems, groupItems)) {
      availableGroupItems = []
      for (const matchingGroupNumItem of matchingGroupNumItems) {
        matchingGroupNumItem.num++
        remainParticipateUserNum--
        if (remainParticipateUserNum <= 0) {
          return matchingGroupNumItems
        }
      }
    }

    for (const availableGroupItem of availableGroupItems) {
      for (const matchingGroupNumItem of matchingGroupNumItems) {
        if (matchingGroupNumItem.groupUid === availableGroupItem.uid && availableGroupItem.maxNum as number > matchingGroupNumItem.num) {
          remainParticipateUserNum--
          matchingGroupNumItem.num++
        }
      }
    }
  }

  return matchingGroupNumItems
}

// ********
// main関数
// ********
export default (roomItems: Room[]) =>
  Promise.all(roomItems.map(async (roomItem) => {
    // group変数の初期化
    const groupItems = await firestotreGetGroupItems(roomItem.uid as string)
    const groupHopeToParticipateUserUidItems: HopeItem[] = groupItems.map((item) => { return { uid: item.uid as string, hopeUidItems: item.hopeParticipateUserUidItems } })
    const groupLength = groupItems.length
    const groupRateMaxNum = roomItem.groupHopeMaxNum || groupLength
    // participate user変数の初期化
    const participateUserItems = await firestotreGetParticipateUserItem(roomItem.uid as string)
    const participateUserHopeToGroupUidItems: HopeItem[] = participateUserItems.map((item) => { return { uid: item.uid as string, hopeUidItems: item.hopeGroupUidItems } })
    const participateUserLength = participateUserItems.length
    const participateUserRateMaxNum = roomItem.participateUserHopeMaxNum || participateUserLength

    // ----------------------
    // --- アルゴリズムの実装 ---

    // Step 1
    // レート更新
    const groupRateItems = getInitRateItems(participateUserHopeToGroupUidItems, groupItems, groupRateMaxNum)
    const participateUserRateItems = getInitRateItems(groupHopeToParticipateUserUidItems, participateUserItems, participateUserRateMaxNum)
    
    // Step 2
    // グループをレート順にソート
    groupRateItems.sort(function (a, b) {
      if (a.rate < b.rate) return 1
      else return -1
    })

    // Step 3
    // Algorithm Step 1
    // グループマッチングの人数を整理

    const matchingGroupNumItems = algorithmStep1(groupItems, groupLength, participateUserLength)

    participateUserRateItems
    console.log(matchingGroupNumItems)
  
    // Step 4
    // Algorithm Step 2
    // すべての参加者を未マッチングにする

    // Step 5
    // Algorithm Step 3
    // 希望を提出した参加者のマッチング処理

    // Step 6
    // マッチング度が高い参加者を確定処理する

    // Step 7
    // マッチングされてない参加者をランダムでマッチングする

    // --- アルゴリズムの終了 ---
    // ----------------------

    // storeに保存
  })).catch((err) => {
    console.log(err)
    // throw new Error(err)
  })
