/*
  Warnings:

  - You are about to drop the column `details` on the `activities` table. All the data in the column will be lost.
  - You are about to drop the column `show_activity` on the `activities` table. All the data in the column will be lost.
  - You are about to drop the column `state` on the `activities` table. All the data in the column will be lost.
  - Added the required column `revoked` to the `activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `showActivity` to the `activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `twoWayLink` to the `activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `verified` to the `activities` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "activities" DROP COLUMN "details",
DROP COLUMN "show_activity",
DROP COLUMN "state",
ADD COLUMN     "revoked" BOOLEAN,
ADD COLUMN     "showActivity" BOOLEAN NOT NULL,
ADD COLUMN     "twoWayLink" BOOLEAN NOT NULL,
ADD COLUMN     "type" TEXT NOT NULL,
ADD COLUMN     "verified" BOOLEAN NOT NULL;
