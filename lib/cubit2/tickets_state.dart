part of 'tickets_cubit.dart';

@immutable
sealed class TicketsState {}

final class TicketsInitial extends TicketsState {}

final class TicketsSuccess extends TicketsState {
}
final class TicketDeleteSuccess extends TicketsState {
}

final class TicketUpdateSuccess extends TicketsState {
}

final class TicketsLoading extends TicketsState {}

final class NoTicketsFound extends TicketsState {}

final class TicketsError extends TicketsState {
  final String errMassage;

  TicketsError(this.errMassage);
}

final class ShippingSuccess extends TicketsState {
}

final class PayingLoading extends TicketsState {
}

final class ShippingLoading extends TicketsState {}

final class ShippingError extends TicketsState {
  final String errMassage;

  ShippingError(this.errMassage);
}