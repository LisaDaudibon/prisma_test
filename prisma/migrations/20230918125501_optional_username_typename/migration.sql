/*
  Warnings:

  - You are about to drop the column `activityName` on the `activities` table. All the data in the column will be lost.
  - The primary key for the `types` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `types` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[activityUserName]` on the table `activities` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `activityUserName` to the `activities` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "activities" DROP CONSTRAINT "activities_typeName_fkey";

-- DropForeignKey
ALTER TABLE "activities" DROP CONSTRAINT "activities_user_global_name_fkey";

-- DropIndex
DROP INDEX "activities_activityName_key";

-- AlterTable
ALTER TABLE "activities"
RENAME COLUMN "activityName" TO "activityUserName";

ALTER TABLE "activities"
ALTER COLUMN "typeName" DROP NOT NULL,
ALTER COLUMN "user_global_name" DROP NOT NULL;

-- AlterTable
ALTER TABLE "types" DROP CONSTRAINT "types_pkey",
DROP COLUMN "id",
ALTER COLUMN "name" DROP DEFAULT,
ADD CONSTRAINT "types_pkey" PRIMARY KEY ("name");

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "global_name" DROP DEFAULT;

-- CreateIndex
CREATE UNIQUE INDEX "activities_activityUserName_key" ON "activities"("activityUserName");

-- AddForeignKey
ALTER TABLE "activities" ADD CONSTRAINT "activities_user_global_name_fkey" FOREIGN KEY ("user_global_name") REFERENCES "users"("global_name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "activities" ADD CONSTRAINT "activities_typeName_fkey" FOREIGN KEY ("typeName") REFERENCES "types"("name") ON DELETE SET NULL ON UPDATE CASCADE;
