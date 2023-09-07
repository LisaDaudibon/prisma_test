-- DropForeignKey
ALTER TABLE "_memberOfGuild" DROP CONSTRAINT "_memberOfGuild_A_fkey";

-- DropForeignKey
ALTER TABLE "_memberOfGuild" DROP CONSTRAINT "_memberOfGuild_B_fkey";

-- DropTable
DROP TABLE "Guild";

-- DropTable
DROP TABLE "VerificationRequest";

-- DropTable
DROP TABLE "_memberOfGuild";

