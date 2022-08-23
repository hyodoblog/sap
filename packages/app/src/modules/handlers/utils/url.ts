export class UrlUtil {
  private baseStorageUrl = `https://storage.googleapis.com/${process.env.FB_STORAGE_BUCKET}/`
  public defaultIconUrl = 'https://storage.googleapis.com/lea-sp.appspot.com/default-icon.jpeg'

  public getImgUrl(imgPath: string, updatedAt?: number): string {
    const imgUrl = this.baseStorageUrl + imgPath
    if (updatedAt) {
      return `${imgUrl}?${updatedAt}`
    } else {
      return imgUrl
    }
  }
}
