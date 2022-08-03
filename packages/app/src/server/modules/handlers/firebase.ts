import { Request } from 'express'
import { DecodedIdToken } from 'firebase-admin/auth'
import { FieldValue, Timestamp } from 'firebase-admin/firestore'
import { auth } from '../../config/firebase'

const getIdToken = (req: Request): string => {
  if (!req.headers.authorization) {
    throw new Error('Authorization header is not found.')
  }

  const match = req.headers.authorization.match(/^Bearer (.*)$/)
  if (match) {
    const idToken = match[1]
    return idToken
  } else {
    throw new Error('Authorization header is not set Bearer token.')
  }
}

export const firebaseVerifyIdToken = async (req: Request): Promise<DecodedIdToken> => {
  const idToken = getIdToken(req)
  return await auth.verifyIdToken(idToken)
}

export const getServerTimestamp = () => FieldValue.serverTimestamp()

export const converTimestamp = (secondes: number) => Timestamp.fromMillis(secondes * 1000)
