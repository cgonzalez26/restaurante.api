/*
  Warnings:

  - You are about to drop the column `tableId` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `orderId` on the `User` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_tableId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_orderId_fkey";

-- DropIndex
DROP INDEX "Order_tableId_key";

-- AlterTable
ALTER TABLE "Branch" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "tableId",
ADD COLUMN     "usertableId" TEXT;

-- AlterTable
ALTER TABLE "ProductModifier" ADD COLUMN     "modifierId" TEXT;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "orderId";

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_usertableId_fkey" FOREIGN KEY ("usertableId") REFERENCES "UserTable"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductModifier" ADD CONSTRAINT "ProductModifier_modifierId_fkey" FOREIGN KEY ("modifierId") REFERENCES "Modifiers"("id") ON DELETE SET NULL ON UPDATE CASCADE;
