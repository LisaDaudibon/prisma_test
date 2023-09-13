import 'next-auth/jwt'
import { DefaultSession } from 'next-auth'

declare module 'next-auth/jwt' {
  interface JWT {
    discriminator: string
    global_name: string
    verified: boolean
    mfa_enabled: boolean
    banner: string
    playerName: string
    discordGuild: DiscordGuild[]
  }
  interface DiscordGuild {
    discordGuildName: string
    icon: string
    ownerId: string
    approximate_number_count: integer
    approximate_presence_count: integer
    description: string
    guildName: string
    // jwt: JWT[]
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
      discordGuild: DiscordGuild[]
    } & DefaultSession['user']
  }

  interface User {
    discriminator: string
    global_name: string
    verified: boolean
    mfa_enabled: boolean
    banner: string
    playerName: string
    discordGuild: DiscordGuild[]
  }
  interface DiscordGuild {
    discordGuildName: string
    icon: string
    owner_id: string
    approximate_number_count: integer
    approximate_presence_count: integer
    description: string
    guildName: string
    // user: User[]
  }
}