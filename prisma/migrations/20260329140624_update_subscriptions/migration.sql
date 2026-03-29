/*
  Warnings:

  - You are about to drop the column `accountType` on the `Account` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('success', 'failed', 'pending', 'refunded');

-- AlterTable
ALTER TABLE "Account" DROP COLUMN "accountType";

-- CreateTable
CREATE TABLE "accountSubscription" (
    "id" SERIAL NOT NULL,
    "accountId" INTEGER NOT NULL,
    "paidStatus" BOOLEAN NOT NULL,
    "freePlanEnabled" BOOLEAN NOT NULL,
    "PaidType" "AccountType" NOT NULL DEFAULT 'free',
    "PaidMaxAppLimits" INTEGER NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "renewalData" TIMESTAMP(3) NOT NULL,
    "autoRenew" BOOLEAN NOT NULL,
    "lastPaymentId" INTEGER NOT NULL,

    CONSTRAINT "accountSubscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payments" (
    "id" SERIAL NOT NULL,
    "subscriptionId" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "currency" TEXT NOT NULL,
    "paymentMethod" TEXT NOT NULL,
    "status" "PaymentStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Payments_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "accountSubscription" ADD CONSTRAINT "accountSubscription_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES "accountSubscription"("id") ON DELETE CASCADE ON UPDATE CASCADE;
