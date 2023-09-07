-- CreateTable
CREATE TABLE "Guild" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Guild_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_memberOfGuild" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Guild_name_key" ON "Guild"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_memberOfGuild_AB_unique" ON "_memberOfGuild"("A", "B");

-- CreateIndex
CREATE INDEX "_memberOfGuild_B_index" ON "_memberOfGuild"("B");

-- AddForeignKey
ALTER TABLE "_memberOfGuild" ADD CONSTRAINT "_memberOfGuild_A_fkey" FOREIGN KEY ("A") REFERENCES "Guild"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_memberOfGuild" ADD CONSTRAINT "_memberOfGuild_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
