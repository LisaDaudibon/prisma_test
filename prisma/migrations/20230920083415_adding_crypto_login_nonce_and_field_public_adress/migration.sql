/*
  Warnings:

  - A unique constraint covering the columns `[publicAddress]` on the table `users` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "users" ADD COLUMN     "publicAddress" TEXT;

-- CreateTable
CREATE TABLE "CryptoLoginNonce" (
    "userId" TEXT NOT NULL,
    "nonce" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "CryptoLoginNonce_userId_key" ON "CryptoLoginNonce"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "users_publicAddress_key" ON "users"("publicAddress");

-- AddForeignKey
ALTER TABLE "CryptoLoginNonce" ADD CONSTRAINT "CryptoLoginNonce_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
