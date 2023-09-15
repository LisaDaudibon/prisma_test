-- AlterTable
ALTER TABLE "discord_guilds" ALTER COLUMN "approximate_number_count" DROP NOT NULL,
ALTER COLUMN "approximate_presence_count" DROP NOT NULL;
