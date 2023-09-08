/*
  Warnings:

  - You are about to drop the `_ActivityToUser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_DiscordGuildToUser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_RoleToUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_ActivityToUser" DROP CONSTRAINT "_ActivityToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_ActivityToUser" DROP CONSTRAINT "_ActivityToUser_B_fkey";

-- DropForeignKey
ALTER TABLE "_DiscordGuildToUser" DROP CONSTRAINT "_DiscordGuildToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_DiscordGuildToUser" DROP CONSTRAINT "_DiscordGuildToUser_B_fkey";

-- DropForeignKey
ALTER TABLE "_RoleToUser" DROP CONSTRAINT "_RoleToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_RoleToUser" DROP CONSTRAINT "_RoleToUser_B_fkey";

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "discriminator" DROP NOT NULL,
ALTER COLUMN "mfa_enabled" DROP NOT NULL,
ALTER COLUMN "verified" DROP NOT NULL;

-- DropTable
DROP TABLE "_ActivityToUser";

-- DropTable
DROP TABLE "_DiscordGuildToUser";

-- DropTable
DROP TABLE "_RoleToUser";
