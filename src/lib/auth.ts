import { prisma } from "@/lib/prisma";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import { DiscordGuild } from "@prisma/client";
import type { NextAuthOptions } from "next-auth";
import DiscordProvider from "next-auth/providers/discord";


export const authOptions: NextAuthOptions = {
  adapter: PrismaAdapter(prisma),
  // pages: {
  //   signIn: "/login",
  // },
  session: {
    strategy: "jwt",
  },

  providers: [
    DiscordProvider({
      clientId: process.env.DISCORD_CLIENT_ID as string,
      clientSecret: process.env.DISCORD_CLIENT_SECRET as string,
      authorization: { params: { scope: "identify email guilds guilds.members.read connections" } },

      profile(profile) {
        if (profile.avatar === null) {
          const defaultAvatarNumber = parseInt(profile.discriminator) % 5;
          profile.image_url = `https://cdn.discordapp.com/embed/avatars/${defaultAvatarNumber}.png`;
        } else {
          const format = profile.avatar.startsWith("a_") ? "gif" : "png";
          profile.image_url = `https://cdn.discordapp.com/avatars/${profile.id}/${profile.avatar}.${format}`;
        }
        return {
          id: profile.id as string,
          name: profile.username as string,
          discriminator: profile.discriminator as string, // Fixed typo
          global_name: profile.global_name as string,
          verified: profile.verified as boolean,
          mfa_enabled: profile.mfa_enabled as boolean,
          banner: profile.banner as string,
          email: profile.email as string,
          image: profile.image_url as string,
          playerName: profile.playerName as string,
          access_token: profile.access_token as string,
        };
      },
    }),
  ],
  callbacks: {
    async redirect({ url, baseUrl }) {
      if (url.startsWith("/")) return `${baseUrl}${url}`

    return baseUrl
    },
    session: ({ session, token }) => {
      return {
        ...session,
        user: {
          ...session.user,
          id: token.id,
          discriminator: token.discriminator,
          global_name: token.global_name,
          verified: token.verified,
          mfa_enabled: token.mfa_enabled,
          banner: token.banner,
          playerName: token.playerName,
          access_token: token.access_token
        },
      };
    },
    jwt: async ({ token, user, account }) => {
      // let activitiesData;

      // if (account?.access_token) {
      //   const activitiesResponse = await fetch("https://discord.com/api/users/@me/connections", {
      //     headers: {
      //       Authorization: `Bearer ${account.access_token}`, // Utilisez le jeton OAuth correct
      //     },
      //   });

      //   console.log("Activities response:", activitiesResponse);

      //   if (activitiesResponse.ok) {
      //     const activitiesData = await activitiesResponse.json();
      //     console.log("Activities data:", activitiesData);

      //     token.discordActivities = activitiesData;
      //   } else {
      //     console.log("No response or error:", activitiesResponse.statusText);
      //   }
      // }

      if (user) {
        const u = user as unknown as any;
        const a = account as unknown as any;

        return {
          ...token,
          id: u.id,
          discriminator: u.discriminator,
          global_name: u.global_name,
          verified: u.verified,
          mfa_enabled: u.mfa_enabled,
          banner: u.banner,
          playerName: u.playerName,
          access_token: a.access_token
        };
      }
      return token;
    },
  },
}
