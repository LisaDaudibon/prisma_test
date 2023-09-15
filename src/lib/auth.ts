import { prisma } from "@/lib/prisma";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import { DiscordGuild } from "@prisma/client";

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
          global_name: profile.global_name as string,
          verified: profile.verified as boolean,
          mfa_enabled: profile.mfa_enabled as boolean,
          banner: profile.banner as string,
          email: profile.email as string,
          image: profile.image_url as string,
          playerName: profile.playerName as string,
          discordGuild: profile.discordGuild
        };
      },
    }),
  ],
  callbacks: {
    // async redirect({ baseUrl }) {
    //   return `${baseUrl}/openloot`
    // },
    session: ({ session, token }) => {
      console.log("session", session)
      // console.log("token session", token)
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
          discordGuild: token.discordGuild,

        },
      };
    },
    jwt: async ({ token, user, account }) => {
      if (account?.access_token) {
        const guildsResponse = await fetch("https://discord.com/api/users/@me/guilds", {
          headers: {
            Authorization: `Bearer ${account.access_token}`, // Utilisez le jeton OAuth correct
          },
        });

        if (guildsResponse.ok) {
          const guildsData = await guildsResponse.json();
          token.discordGuilds = guildsData;

          // console.log(guildsData)
        }
      }

      if (user) {
        const u = user as unknown as any;
        // const g = guild as unknown as any;
        return {
          ...token,
          id: u.id,
          discriminator: u.discriminator,
          global_name: u.global_name,
          verified: u.verified,
          mfa_enabled: u.mfa_enabled,
          banner: u.banner,
          playerName: u.playerName,
          // discordId: u.DiscordGuilds.id,
          // discordName: u.DiscordGuilds.name,
          // discordId: discordGuild.id
        };
      }
      // console.log("token", token)
      // console.log("user jwt", guildsData)
      return token;
    },
  },
  events: {
    signIn: async ({ user }) => {
      console.log(user)
      if (user.discordGuild) {
        await Promise.all(
          user.discordGuild.map(async (guild) => {
            await prisma.discordGuild.create({
              data: {
                discordGuildName: guild.discordGuildName, // ou autre logique pour déterminer ce champ
                icon: guild.icon,
                ownerId: guild.owner_id,
                approximate_number_count: guild.approximate_number_count,
                approximate_presence_count: guild.approximate_presence_count,
                description: guild.description,
                createdAt: new Date(),
                updatedAt: new Date(),
              },
            });
          })
        );
      }
      console.log("user", user)

    },
  },
};
