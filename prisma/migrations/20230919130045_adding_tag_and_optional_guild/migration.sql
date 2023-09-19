-- AlterTable
ALTER TABLE "Guild" ADD COLUMN     "tag" TEXT,
ALTER COLUMN "discordUrl" DROP NOT NULL;
