import type { NextApiRequest, NextApiResponse } from "next"
import NextAuth from "next-auth"

export default async function auth(req: NextApiRequest, res: NextApiResponse) {

  async function fetchDiscordGuilds(accessToken: string) {
    const guildsResponse = await fetch("https://discord.com/api/users/@me/guilds", {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    });

  // return await NextAuth(req, res, {
    
  // })
}
}