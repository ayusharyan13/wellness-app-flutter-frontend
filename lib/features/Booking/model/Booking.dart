class Booking {
  final int appointmentId;
  final String phoneNumber;
  final String serviceType;
  final String slotStartTime;
  final String slotEndTime;
  final String status;
  final int consultantId;

  Booking({
    required this.appointmentId,
    required this.phoneNumber,
    required this.serviceType,
    required this.slotStartTime,
    required this.slotEndTime,
    required this.status,
    required this.consultantId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      appointmentId: json['id'] as int,
      phoneNumber: json['phoneNumber'] as String,
      serviceType: json['serviceType'] as String,
      slotStartTime: json['slotStartTime'] as String,
      slotEndTime: json['slotEndTime'] as String,
      status: json['status'],
      consultantId: json['consultant'] as int,
    );
  }
}
