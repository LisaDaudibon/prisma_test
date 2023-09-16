/*
  Warnings:

  - You are about to drop the `_RoleToUser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `roles` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_RoleToUser" DROP CONSTRAINT "_RoleToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_RoleToUser" DROP CONSTRAINT "_RoleToUser_B_fkey";

-- DropForeignKey
ALTER TABLE "roles" DROP CONSTRAINT "roles_discordGuildName_fkey";

-- AlterTable
ALTER TABLE "activities" ALTER COLUMN "revoked" SET DEFAULT false,
ALTER COLUMN "showActivity" SET DEFAULT false,
ALTER COLUMN "twoWayLink" SET DEFAULT false,
ALTER COLUMN "verified" SET DEFAULT false;

-- DropTable
DROP TABLE "_RoleToUser";

-- DropTable
DROP TABLE "roles";
