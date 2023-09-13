/*
  Warnings:

  - You are about to drop the `Activity` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DiscordGuild` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Role` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "DiscordGuild" DROP CONSTRAINT "DiscordGuild_guildName_fkey";

-- DropForeignKey
ALTER TABLE "Role" DROP CONSTRAINT "Role_discordGuildName_fkey";

-- DropForeignKey
ALTER TABLE "_DiscordGuildToUser" DROP CONSTRAINT "_DiscordGuildToUser_A_fkey";

-- DropTable
DROP TABLE "Activity";

-- DropTable
DROP TABLE "DiscordGuild";

-- DropTable
DROP TABLE "Role";

-- CreateTable
CREATE TABLE "discord_guilds" (
    "id" SERIAL NOT NULL,
    "discordGuildName" TEXT NOT NULL,
    "guildName" TEXT,
    "icon" TEXT,
    "ownerId" TEXT,
    "approximate_number_count" INTEGER NOT NULL,
    "approximate_presence_count" INTEGER NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "discord_guilds_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "roleName" TEXT NOT NULL,
    "discordGuildName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "activities" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "activityName" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "details" TEXT NOT NULL,
    "show_activity" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "activities_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "discord_guilds_discordGuildName_key" ON "discord_guilds"("discordGuildName");

-- CreateIndex
CREATE UNIQUE INDEX "discord_guilds_guildName_key" ON "discord_guilds"("guildName");

-- CreateIndex
CREATE UNIQUE INDEX "roles_roleName_key" ON "roles"("roleName");

-- CreateIndex
CREATE UNIQUE INDEX "roles_discordGuildName_key" ON "roles"("discordGuildName");

-- CreateIndex
CREATE UNIQUE INDEX "activities_activityName_key" ON "activities"("activityName");

-- AddForeignKey
ALTER TABLE "discord_guilds" ADD CONSTRAINT "discord_guilds_guildName_fkey" FOREIGN KEY ("guildName") REFERENCES "Guild"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "roles" ADD CONSTRAINT "roles_discordGuildName_fkey" FOREIGN KEY ("discordGuildName") REFERENCES "discord_guilds"("discordGuildName") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DiscordGuildToUser" ADD CONSTRAINT "_DiscordGuildToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "discord_guilds"("id") ON DELETE CASCADE ON UPDATE CASCADE;
