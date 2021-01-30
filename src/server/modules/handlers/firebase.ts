import { Request } from 'express'
import { admin } from '../../config/firebase'

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

export const firebaseVerifyIdToken = async (req: Request): Promise<admin.auth.DecodedIdToken> => {
  const idToken = getIdToken(req)
  return await admin.auth().verifyIdToken(idToken)
}

export const getServerTimestamp = () => admin.firestore.FieldValue.serverTimestamp()
