/*
  Warnings:

  - You are about to drop the column `applicationId` on the `activities` table. All the data in the column will be lost.
  - You are about to drop the column `showActivity` on the `activities` table. All the data in the column will be lost.
  - You are about to drop the column `twoWayLink` on the `activities` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `activities` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[accountConnectionId]` on the table `activities` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `accountConnectionId` to the `activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `typeName` to the `activities` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "activities" DROP COLUMN "applicationId",
DROP COLUMN "showActivity",
DROP COLUMN "twoWayLink",
DROP COLUMN "type",
ADD COLUMN     "accountConnectionId" TEXT NOT NULL,
ADD COLUMN     "friend_sync" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "show_activity" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "two_way_link" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "typeName" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Type_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Type_name_key" ON "Type"("name");

-- CreateIndex
CREATE UNIQUE INDEX "activities_accountConnectionId_key" ON "activities"("accountConnectionId");

-- AddForeignKey
ALTER TABLE "activities" ADD CONSTRAINT "activities_typeName_fkey" FOREIGN KEY ("typeName") REFERENCES "Type"("name") ON DELETE RESTRICT ON UPDATE CASCADE;
