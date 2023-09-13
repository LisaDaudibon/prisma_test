/*
  Warnings:

  - Added the required column `updatedAt` to the `Activity` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Activity" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "DiscordGuild" ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Role" ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;
