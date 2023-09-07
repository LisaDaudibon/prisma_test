/*
  Warnings:

  - You are about to drop the column `user_id` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `sessions` table. All the data in the column will be lost.
  - Added the required column `oracle_user_id` to the `accounts` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "accounts" DROP CONSTRAINT "accounts_user_id_fkey";

-- DropForeignKey
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_user_id_fkey";

-- AlterTable
ALTER TABLE "accounts" DROP COLUMN "user_id",
ADD COLUMN     "oracle_user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "sessions" DROP COLUMN "user_id",
ADD COLUMN     "oracle_user_id" TEXT;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_oracle_user_id_fkey" FOREIGN KEY ("oracle_user_id") REFERENCES "oraclesusers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_oracle_user_id_fkey" FOREIGN KEY ("oracle_user_id") REFERENCES "oraclesusers"("id") ON DELETE CASCADE ON UPDATE CASCADE;
