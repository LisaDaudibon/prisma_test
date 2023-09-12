/*
  Warnings:

  - You are about to drop the `_DiscordGuildToUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_DiscordGuildToUser" DROP CONSTRAINT "_DiscordGuildToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_DiscordGuildToUser" DROP CONSTRAINT "_DiscordGuildToUser_B_fkey";

-- DropTable
DROP TABLE "_DiscordGuildToUser";
