/*
  Warnings:

  - A unique constraint covering the columns `[discordUrl]` on the table `Guild` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[discordGuildId]` on the table `discord_guilds` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `discordUrl` to the `Guild` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Guild" ADD COLUMN     "discordUrl" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "discord_guilds" ADD COLUMN     "discordGuildId" TEXT NOT NULL DEFAULT 'none';

-- CreateIndex
CREATE UNIQUE INDEX "Guild_discordUrl_key" ON "Guild"("discordUrl");

