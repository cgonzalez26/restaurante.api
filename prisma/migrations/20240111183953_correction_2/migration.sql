/*
  Warnings:

  - The values [CALL,ORDER,PAYMENT,FEEDBACK,INFORMATIVE,OTHER] on the enum `NotificationType` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `branchId` on the `Product` table. All the data in the column will be lost.
  - The `productType` column on the `Product` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "ProductType" AS ENUM ('products', 'modifiers', 'modifiergroups', 'bundles');

-- AlterEnum
BEGIN;
CREATE TYPE "NotificationType_new" AS ENUM ('call', 'order', 'payment', 'feedback', 'informative', 'other');
ALTER TABLE "Notification" ALTER COLUMN "type_temp" TYPE "NotificationType_new" USING ("type_temp"::text::"NotificationType_new");
ALTER TYPE "NotificationType" RENAME TO "NotificationType_old";
ALTER TYPE "NotificationType_new" RENAME TO "NotificationType";
DROP TYPE "NotificationType_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_branchId_fkey";

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "branchId",
DROP COLUMN "productType",
ADD COLUMN     "productType" "ProductType";

-- CreateTable
CREATE TABLE "BranchProduct" (
    "id" TEXT NOT NULL,
    "branchId" TEXT,
    "productId" TEXT,
    "updatedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BranchProduct_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "BranchProduct_id_key" ON "BranchProduct"("id");

-- AddForeignKey
ALTER TABLE "BranchProduct" ADD CONSTRAINT "BranchProduct_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "Branch"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BranchProduct" ADD CONSTRAINT "BranchProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;
