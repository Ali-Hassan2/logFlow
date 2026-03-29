/*
  Warnings:

  - You are about to drop the column `username` on the `Account` table. All the data in the column will be lost.
  - Added the required column `companyName` to the `Account` table without a default value. This is not possible if the table is not empty.
  - Added the required column `useCase` to the `Account` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UseCase" AS ENUM ('startup', 'personal', 'enterprise', 'education', 'sideProject');

-- DropIndex
DROP INDEX "Account_username_key";

-- AlterTable
ALTER TABLE "Account" DROP COLUMN "username",
ADD COLUMN     "companyName" TEXT NOT NULL,
ADD COLUMN     "useCase" "UseCase" NOT NULL;
