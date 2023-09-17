/*
  Warnings:

  - You are about to drop the `Type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ActivityToUser` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[global_name]` on the table `users` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_global_name` to the `activities` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_ActivityToUser" DROP CONSTRAINT "_ActivityToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_ActivityToUser" DROP CONSTRAINT "_ActivityToUser_B_fkey";

-- DropForeignKey
ALTER TABLE "activities" DROP CONSTRAINT "activities_typeName_fkey";

-- AlterTable
ALTER TABLE "activities" ADD COLUMN     "user_global_name" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "discriminator" DROP DEFAULT;

-- DropTable
DROP TABLE "Type";

-- DropTable
DROP TABLE "_ActivityToUser";

-- CreateTable
CREATE TABLE "types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "types_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "types_name_key" ON "types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "users_global_name_key" ON "users"("global_name");

-- AddForeignKey
ALTER TABLE "activities" ADD CONSTRAINT "activities_user_global_name_fkey" FOREIGN KEY ("user_global_name") REFERENCES "users"("global_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "activities" ADD CONSTRAINT "activities_typeName_fkey" FOREIGN KEY ("typeName") REFERENCES "types"("name") ON DELETE RESTRICT ON UPDATE CASCADE;
