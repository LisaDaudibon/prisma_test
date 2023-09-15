/*
  Warnings:

  - A unique constraint covering the columns `[discordGuildId]` on the table `discord_guilds` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "discord_guilds" ALTER COLUMN "discordGuildId" DROP DEFAULT;

-- CreateIndex
CREATE UNIQUE INDEX "discord_guilds_discordGuildId_key" ON "discord_guilds"("discordGuildId");
