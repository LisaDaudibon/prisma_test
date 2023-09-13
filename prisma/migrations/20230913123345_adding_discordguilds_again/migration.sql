-- CreateTable
CREATE TABLE "_DiscordGuildToUser" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_DiscordGuildToUser_AB_unique" ON "_DiscordGuildToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_DiscordGuildToUser_B_index" ON "_DiscordGuildToUser"("B");

-- AddForeignKey
ALTER TABLE "_DiscordGuildToUser" ADD CONSTRAINT "_DiscordGuildToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "DiscordGuild"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DiscordGuildToUser" ADD CONSTRAINT "_DiscordGuildToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
