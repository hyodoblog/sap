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

  public str2Array(str: string) {
    const array = []
    for (let i = 0; i < str.length; i++) array.push(str.charCodeAt(i))
    return array
  }
}
