import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { EventsModule } from './events/events.module';
import { VenuesModule } from './venues/venues.module';
import { CategoriesModule } from './categories/categories.module';
import { TicketTypesModule } from './ticket-types/ticket-types.module';
import { SeatmapModule } from './seatmap/seatmap.module';
import { PromoModule } from './promo/promo.module';
import { OrdersModule } from './orders/orders.module';
import { PaymentsModule } from './payments/payments.module';
import { TicketsModule } from './tickets/tickets.module';
import { CheckinModule } from './checkin/checkin.module';
import { NotificationsModule } from './notifications/notifications.module';
import { ReviewsModule } from './reviews/reviews.module';
import { AdminModule } from './admin/admin.module';

@Module({
  imports: [UsersModule, PrismaModule, AuthModule, EventsModule, VenuesModule, CategoriesModule, TicketTypesModule, SeatmapModule, PromoModule, OrdersModule, PaymentsModule, TicketsModule, CheckinModule, NotificationsModule, ReviewsModule, AdminModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
