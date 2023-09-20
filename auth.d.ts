import 'next-auth/jwt'
import { DefaultSession } from 'next-auth'

declare module 'next-auth/jwt' {
interface JWT {
  discriminator?: string | null
  global_name?: string | null
  verified?: boolean | null
  mfa_enabled?: boolean | null
  banner?: string | null
  playerName?: string | null
  access_token:string
  }
}

declare module 'next-auth' {
interface Session {
  user: {
    discriminator: string
    global_name: string
    verified: boolean
    mfa_enabled: boolean
    banner: string
    playerName: string
    access_token: string
    } & DefaultSession['user']
}

  interface User {
    discriminator?: string
    global_name?: string
    verified?: boolean
    mfa_enabled?: boolean
    banner?: string
    playerName?: string
  }
}