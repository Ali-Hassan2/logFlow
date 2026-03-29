-- CreateEnum
CREATE TYPE "Role" AS ENUM ('admin', 'member');

-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('free', 'basic', 'standard', 'premium');

-- CreateEnum
CREATE TYPE "appLogLevel" AS ENUM ('error', 'warning', 'info', 'debug');

-- CreateEnum
CREATE TYPE "appEnviornment" AS ENUM ('prod', 'uat', 'stagging', 'dev');

-- CreateEnum
CREATE TYPE "errorStatus" AS ENUM ('open', 'resolved', 'ignored');

-- CreateEnum
CREATE TYPE "alertChannel" AS ENUM ('slack', 'email', 'gmail', 'whatsapp', 'pushNotification');

-- CreateEnum
CREATE TYPE "sdkPlatform" AS ENUM ('node', 'python', 'springboot');

-- CreateTable
CREATE TABLE "Account" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "verificationCode" INTEGER,
    "isVerifiedAccount" BOOLEAN NOT NULL DEFAULT false,
    "verificationCodeExpiry" TIMESTAMP(3),
    "accountType" "AccountType" NOT NULL DEFAULT 'free',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "image" JSONB,
    "usageLimit" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Apps" (
    "id" SERIAL NOT NULL,
    "accountId" INTEGER NOT NULL,
    "appName" TEXT NOT NULL,
    "appId" TEXT NOT NULL,
    "apiKey" TEXT NOT NULL,
    "isFree" BOOLEAN NOT NULL DEFAULT true,
    "maxLimit" TEXT,
    "usedLimit" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Apps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AppLogs" (
    "id" SERIAL NOT NULL,
    "appId" INTEGER NOT NULL,
    "level" "appLogLevel" NOT NULL,
    "message" TEXT NOT NULL,
    "stackTrace" TEXT,
    "fileName" TEXT,
    "lineNo" TEXT,
    "enviornment" "appEnviornment" NOT NULL,
    "timeStamps" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "releaseVersion" TEXT,
    "sessionId" TEXT,
    "metaData" JSONB,
    "errorGroupId" INTEGER,

    CONSTRAINT "AppLogs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ErrorGroups" (
    "id" SERIAL NOT NULL,
    "appId" INTEGER NOT NULL,
    "fingerprint" TEXT NOT NULL,
    "firstSeen" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastSeen" TIMESTAMP(3) NOT NULL,
    "occurence" INTEGER NOT NULL DEFAULT 1,
    "status" "errorStatus" NOT NULL DEFAULT 'open',

    CONSTRAINT "ErrorGroups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Alerts" (
    "id" SERIAL NOT NULL,
    "message" TEXT NOT NULL,
    "appId" INTEGER NOT NULL,
    "channel" "alertChannel" NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Alerts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AppReleases" (
    "id" SERIAL NOT NULL,
    "appId" INTEGER NOT NULL,
    "version" TEXT NOT NULL,
    "deployAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AppReleases_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SdkEvents" (
    "id" SERIAL NOT NULL,
    "appId" INTEGER NOT NULL,
    "sdkVersion" TEXT NOT NULL,
    "platform" "sdkPlatform" NOT NULL,
    "lastSeen" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SdkEvents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AffectedUsers" (
    "id" SERIAL NOT NULL,
    "appId" INTEGER NOT NULL,
    "errorGroupId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "occurredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AffectedUsers_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_username_key" ON "Account"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Account_email_key" ON "Account"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Apps_appId_key" ON "Apps"("appId");

-- CreateIndex
CREATE UNIQUE INDEX "Apps_apiKey_key" ON "Apps"("apiKey");

-- AddForeignKey
ALTER TABLE "Apps" ADD CONSTRAINT "Apps_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppLogs" ADD CONSTRAINT "AppLogs_appId_fkey" FOREIGN KEY ("appId") REFERENCES "Apps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppLogs" ADD CONSTRAINT "AppLogs_errorGroupId_fkey" FOREIGN KEY ("errorGroupId") REFERENCES "ErrorGroups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ErrorGroups" ADD CONSTRAINT "ErrorGroups_appId_fkey" FOREIGN KEY ("appId") REFERENCES "Apps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Alerts" ADD CONSTRAINT "Alerts_appId_fkey" FOREIGN KEY ("appId") REFERENCES "Apps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppReleases" ADD CONSTRAINT "AppReleases_appId_fkey" FOREIGN KEY ("appId") REFERENCES "Apps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SdkEvents" ADD CONSTRAINT "SdkEvents_appId_fkey" FOREIGN KEY ("appId") REFERENCES "Apps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffectedUsers" ADD CONSTRAINT "AffectedUsers_appId_fkey" FOREIGN KEY ("appId") REFERENCES "Apps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffectedUsers" ADD CONSTRAINT "AffectedUsers_errorGroupId_fkey" FOREIGN KEY ("errorGroupId") REFERENCES "ErrorGroups"("id") ON DELETE CASCADE ON UPDATE CASCADE;
