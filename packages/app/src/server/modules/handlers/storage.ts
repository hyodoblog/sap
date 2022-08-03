import { Storage } from '@google-cloud/storage'
import { storageBucketName } from '../../config/env'

const storage = new Storage({
  credentials: {
    client_email: process.env.GCLOUD_CLIENT_EMAIL,
    private_key: process.env.GCLOUD_PRIVATE_KEY!.replace(/\\n/g, '\n'),
  },
})

const bucket = storage.bucket(storageBucketName)

export const storageSetPublic = (filePath: string): Promise<any> => bucket.file(filePath).makePublic()

export const storageDeleteItem = async (filePath: string): Promise<void> => {
  await bucket.file(filePath).delete()
}
