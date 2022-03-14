import firebase from 'firebase/compat/app'

export class StorageFire {
  private storage: firebase.storage.Storage

  constructor(storage: firebase.storage.Storage) {
    this.storage = storage
  }

  public async upload(filePath: string, file: File): Promise<void> {
    await this.storage.ref(filePath).put(file)
  }

  public async uploadToDataURL(filePath: string, dataURL: string): Promise<void> {
    await this.storage.ref(filePath).putString(dataURL, 'data_url')
  }

  public async delete(filePath: string): Promise<void> {
    await this.storage.ref(filePath).delete()
  }

  public async getDownloadURL(filePath: string): Promise<string> {
    return await this.storage.ref(filePath).getDownloadURL()
  }

  public isFileExist(filePath: string): Promise<boolean> {
    return new Promise((resolve) =>
      this.getDownloadURL(filePath)
        .then(() => resolve(true))
        .catch(() => resolve(false))
    )
  }
}
