/*
  Warnings:

  - You are about to drop the column `global_username` on the `users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "users" 
RENAME "global_username" TO "global_name";
