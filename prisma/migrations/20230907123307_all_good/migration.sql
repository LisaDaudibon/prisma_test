-- DropForeignKey
ALTER TABLE "accounts" DROP CONSTRAINT "accounts_oracle_user_id_fkey";

-- DropForeignKey
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_oracle_user_id_fkey";

-- AlterTable
ALTER TABLE "accounts" DROP COLUMN "oracle_user_id",
ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "sessions" DROP COLUMN "oracle_user_id",
ADD COLUMN     "user_id" TEXT;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "oraclesusers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "oraclesusers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

