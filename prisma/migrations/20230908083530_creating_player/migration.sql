/*
  Warnings:

  - You are about to drop the column `toUser` on the `Drop` table. All the data in the column will be lost.
  - You are about to drop the column `fromUser` on the `OLTransfer` table. All the data in the column will be lost.
  - You are about to drop the column `toUser` on the `OLTransfer` table. All the data in the column will be lost.
  - You are about to drop the column `fromUser` on the `Sale` table. All the data in the column will be lost.
  - You are about to drop the column `toUser` on the `Sale` table. All the data in the column will be lost.
  - You are about to drop the column `oracle_user_id` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `oracle_user_id` on the `sessions` table. All the data in the column will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `oraclesusers` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `toPlayer` to the `Drop` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fromPlayer` to the `OLTransfer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `toPlayer` to the `OLTransfer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fromPlayer` to the `Sale` table without a default value. This is not possible if the table is not empty.
  - Added the required column `toPlayer` to the `Sale` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `accounts` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Drop" DROP CONSTRAINT "Drop_toUser_fkey";

-- DropForeignKey
ALTER TABLE "NFT" DROP CONSTRAINT "NFT_ownerName_fkey";

-- DropForeignKey
ALTER TABLE "Sale" DROP CONSTRAINT "Sale_fromUser_fkey";

-- DropForeignKey
ALTER TABLE "Sale" DROP CONSTRAINT "Sale_toUser_fkey";

-- DropForeignKey
ALTER TABLE "_memberOfGuild" DROP CONSTRAINT "_memberOfGuild_B_fkey";

-- DropForeignKey
ALTER TABLE "accounts" DROP CONSTRAINT "accounts_oracle_user_id_fkey";

-- DropForeignKey
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_oracle_user_id_fkey";

-- AlterTable
ALTER TABLE "Drop" DROP COLUMN "toUser",
ADD COLUMN     "toPlayer" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "OLTransfer" DROP COLUMN "fromUser",
DROP COLUMN "toUser",
ADD COLUMN     "fromPlayer" TEXT NOT NULL,
ADD COLUMN     "toPlayer" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Sale" DROP COLUMN "fromUser",
DROP COLUMN "toUser",
ADD COLUMN     "fromPlayer" TEXT NOT NULL,
ADD COLUMN     "toPlayer" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "accounts" DROP COLUMN "oracle_user_id",
ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "sessions" DROP COLUMN "oracle_user_id",
ADD COLUMN     "user_id" TEXT;

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "oraclesusers";

-- CreateTable
CREATE TABLE "Player" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "spent" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "sold" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "balance" DOUBLE PRECISION NOT NULL DEFAULT 0,

    CONSTRAINT "Player_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "image" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Player_name_key" ON "Player"("name");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "NFT" ADD CONSTRAINT "NFT_ownerName_fkey" FOREIGN KEY ("ownerName") REFERENCES "Player"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_fromPlayer_fkey" FOREIGN KEY ("fromPlayer") REFERENCES "Player"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sale" ADD CONSTRAINT "Sale_toPlayer_fkey" FOREIGN KEY ("toPlayer") REFERENCES "Player"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Drop" ADD CONSTRAINT "Drop_toPlayer_fkey" FOREIGN KEY ("toPlayer") REFERENCES "Player"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_memberOfGuild" ADD CONSTRAINT "_memberOfGuild_B_fkey" FOREIGN KEY ("B") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;
