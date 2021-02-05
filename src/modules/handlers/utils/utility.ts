export class UtilityUtil {
  public getRandomToken(num: number = 20): string {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
    const charsNum = chars.length
    let token = ''
    for (let i = 0; i < num; i++) {
      token += chars[Math.floor(Math.random() * charsNum)]
    }

    return token
  }
}
