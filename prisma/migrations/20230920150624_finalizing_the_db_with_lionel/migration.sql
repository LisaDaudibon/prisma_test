/*
  Warnings:

  - You are about to drop the column `user_global_name` on the `activities` table. All the data in the column will be lost.
  - The primary key for the `discord_guilds` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `discordGuildId` on the `discord_guilds` table. All the data in the column will be lost.
  - You are about to drop the column `discordGuildName` on the `discord_guilds` table. All the data in the column will be lost.
  - You are about to drop the column `publicAddress` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `CryptoLoginNonce` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `discord_guilds` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `name` to the `discord_guilds` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CryptoLoginNonce" DROP CONSTRAINT "CryptoLoginNonce_userId_fkey";

-- DropForeignKey
ALTER TABLE "_DiscordGuildToUser" DROP CONSTRAINT "_DiscordGuildToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "activities" DROP CONSTRAINT "activities_user_global_name_fkey";

-- DropIndex
DROP INDEX "discord_guilds_discordGuildId_key";

-- DropIndex
DROP INDEX "discord_guilds_discordGuildName_key";

-- DropIndex
DROP INDEX "users_global_name_key";

-- DropIndex
DROP INDEX "users_publicAddress_key";

-- AlterTable
ALTER TABLE "_DiscordGuildToUser" ALTER COLUMN "A" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "activities" DROP COLUMN "user_global_name";

-- AlterTable
ALTER TABLE "discord_guilds" DROP CONSTRAINT "discord_guilds_pkey",
DROP COLUMN "discordGuildId",
DROP COLUMN "discordGuildName",
ADD COLUMN     "name" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "discord_guilds_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "discord_guilds_id_seq";

-- AlterTable
ALTER TABLE "users" DROP COLUMN "publicAddress";

-- DropTable
DROP TABLE "CryptoLoginNonce";

-- CreateIndex
CREATE UNIQUE INDEX "discord_guilds_name_key" ON "discord_guilds"("name");

-- AddForeignKey
ALTER TABLE "_DiscordGuildToUser" ADD CONSTRAINT "_DiscordGuildToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "discord_guilds"("id") ON DELETE CASCADE ON UPDATE CASCADE;
