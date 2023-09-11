import { prisma } from "@/lib/prisma";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import type { NextAuthOptions } from "next-auth";
import DiscordProvider from "next-auth/providers/discord";

export const authOptions: NextAuthOptions = {
  // This is a temporary fix for prisma client.
  // @see https://github.com/prisma/prisma/issues/16117
  adapter: PrismaAdapter(prisma),
  pages: {
    signIn: "/login",
  },
  session: {
    strategy: "jwt",
  },

  providers: [
    DiscordProvider({
      clientId: process.env.DISCORD_CLIENT_ID as string,
      clientSecret: process.env.DISCORD_CLIENT_SECRET as string,
      authorization: { params: { scope: "identify email guilds guilds.members.read connections" } },
      // connection: "https://discord.com/api/users/@me/connections",
      profile(profile) {
        console.log("Received Profile:", profile)
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
          global_username: profile.global_username as string,
          verified: profile.verified as boolean,
          mfa_enabled: profile.mfa_enabled as boolean,
          banner: profile.banner as string,
          email: profile.email as string,
          image: profile.image_url as string,
          playerName: profile.playerName as string
        };
      },
    }),
  ],
  callbacks: {
    async redirect({ baseUrl }) {
      return `${baseUrl}/openloot`
    },
    session: ({ session, token }) => {
      return {
        ...session,
        user: {
          ...session.user,
          id: token.id,
          discriminator: token.discriminator,
          global_username: token.global_username,
          verified: token.verified,
          mfa_enabled: token.mfa_enabled,
          banner: token.banner,
          playerName: token.playerName
        },
      };
    },
    jwt: ({ token, user }) => {
      if (user) {
        const u = user as unknown as any;
        return {
          ...token,
          id: u.id,
          discriminator: u.discriminator,
          global_username: u.global_username,
          verified: u.verified,
          mfa_enabled: u.mfa_enabled,
          banner: u.banner,
          playerName: u.playerName,
        };
      }
      return token;
    },
  },
};