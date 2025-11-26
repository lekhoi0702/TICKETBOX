-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `name` VARCHAR(191) NULL,
    `password` VARCHAR(191) NOT NULL,
    `role` ENUM('BUYER', 'ORGANIZER', 'ADMIN') NOT NULL DEFAULT 'BUYER',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    UNIQUE INDEX `User_phone_key`(`phone`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Event` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `date` DATETIME(3) NOT NULL,
    `time` VARCHAR(191) NULL,
    `organizerId` INTEGER NOT NULL,
    `venueId` INTEGER NULL,
    `categoryId` INTEGER NULL,
    `imageUrl` VARCHAR(191) NULL,
    `status` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `isSeated` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Venue` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `city` VARCHAR(191) NOT NULL,
    `country` VARCHAR(191) NULL DEFAULT 'Vietnam',
    `capacity` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Category_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TicketType` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `eventId` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `price` DOUBLE NOT NULL,
    `quantityAvailable` INTEGER NOT NULL,
    `quantitySold` INTEGER NOT NULL DEFAULT 0,
    `description` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Order` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `totalAmount` DOUBLE NOT NULL,
    `status` ENUM('PENDING', 'PAID', 'CANCELLED', 'REFUNDED') NOT NULL DEFAULT 'PENDING',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OrderItem` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `orderId` INTEGER NOT NULL,
    `ticketTypeId` INTEGER NOT NULL,
    `quantity` INTEGER NOT NULL,
    `price` DOUBLE NOT NULL,
    `seatId` INTEGER NULL,

    UNIQUE INDEX `OrderItem_seatId_key`(`seatId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `orderId` INTEGER NOT NULL,
    `method` ENUM('CREDIT_CARD', 'MOMO', 'BANK_TRANSFER', 'CASH_ON_DELIVERY') NOT NULL,
    `amount` DOUBLE NOT NULL,
    `status` ENUM('PENDING', 'SUCCESS', 'FAILED') NOT NULL DEFAULT 'PENDING',
    `transactionId` VARCHAR(191) NULL,
    `paidAt` DATETIME(3) NULL,

    UNIQUE INDEX `Payment_orderId_key`(`orderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PromoCode` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(191) NOT NULL,
    `discount` DOUBLE NOT NULL,
    `eventId` INTEGER NULL,
    `maxUses` INTEGER NULL,
    `uses` INTEGER NOT NULL DEFAULT 0,
    `validFrom` DATETIME(3) NULL,
    `validTo` DATETIME(3) NULL,

    UNIQUE INDEX `PromoCode_code_key`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Section` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `venueId` INTEGER NOT NULL,
    `capacity` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Seat` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sectionId` INTEGER NOT NULL,
    `row` VARCHAR(191) NOT NULL,
    `seatNumber` VARCHAR(191) NOT NULL,
    `status` ENUM('AVAILABLE', 'BOOKED', 'HOLD', 'DISABLED') NOT NULL DEFAULT 'AVAILABLE',
    `ticketTypeId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_organizerId_fkey` FOREIGN KEY (`organizerId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_venueId_fkey` FOREIGN KEY (`venueId`) REFERENCES `Venue`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TicketType` ADD CONSTRAINT `TicketType_eventId_fkey` FOREIGN KEY (`eventId`) REFERENCES `Event`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderItem` ADD CONSTRAINT `OrderItem_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `Order`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderItem` ADD CONSTRAINT `OrderItem_ticketTypeId_fkey` FOREIGN KEY (`ticketTypeId`) REFERENCES `TicketType`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderItem` ADD CONSTRAINT `OrderItem_seatId_fkey` FOREIGN KEY (`seatId`) REFERENCES `Seat`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `Order`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PromoCode` ADD CONSTRAINT `PromoCode_eventId_fkey` FOREIGN KEY (`eventId`) REFERENCES `Event`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Section` ADD CONSTRAINT `Section_venueId_fkey` FOREIGN KEY (`venueId`) REFERENCES `Venue`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Seat` ADD CONSTRAINT `Seat_sectionId_fkey` FOREIGN KEY (`sectionId`) REFERENCES `Section`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Seat` ADD CONSTRAINT `Seat_ticketTypeId_fkey` FOREIGN KEY (`ticketTypeId`) REFERENCES `TicketType`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
