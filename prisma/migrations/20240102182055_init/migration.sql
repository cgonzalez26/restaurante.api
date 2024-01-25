-- CreateTable
CREATE TABLE "Chain" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Chain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Branch" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "extraAddress" TEXT,
    "city" TEXT NOT NULL,
    "country" TEXT,
    "timezone" TEXT,
    "phone" TEXT,
    "email" TEXT NOT NULL,
    "language" TEXT DEFAULT 'en',
    "image" TEXT,
    "logo" TEXT,
    "managerIds" TEXT[],
    "cuisine" TEXT NOT NULL,
    "wifiName" TEXT,
    "wifiPwd" TEXT,
    "social" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "chainId" TEXT,
    "updatedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Branch_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Branch_email_key" ON "Branch"("email");

-- AddForeignKey
ALTER TABLE "Branch" ADD CONSTRAINT "Branch_chainId_fkey" FOREIGN KEY ("chainId") REFERENCES "Chain"("id") ON DELETE SET NULL ON UPDATE CASCADE;
