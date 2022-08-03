import { FirebaseStorage, ref, uploadBytes } from 'firebase/storage'

export class StorageFire {
  private storage: FirebaseStorage

  constructor(storage: FirebaseStorage) {
    this.storage = storage
  }

  public async upload(filePath: string, file: File): Promise<void> {
    await uploadBytes(ref(this.storage, filePath), file)
  }
}
