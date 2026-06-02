/// Modèle pour représenter un élément d'événement
class EventItem {
  final String id;
  final String title;
  final String description;
  final String? category;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final int? maxParticipants;
  final int? currentParticipants;
  final bool? isActive;
  final String? imageUrl;

  EventItem({
    required this.id,
    required this.title,
    required this.description,
    this.category,
    this.startDate,
    this.endDate,
    this.location,
    this.maxParticipants,
    this.currentParticipants,
    this.isActive,
    this.imageUrl,
  });

  /// Crée un EventItem placeholder pour les cas de chargement
  static EventItem placeholder({required String id}) {
    return EventItem(
      id: id,
      title: 'Event $id',
      description: 'Chargement en cours...',
      category: 'Général',
      isActive: true,
    );
  }

  /// Crée une copie avec modifications possibles
  EventItem copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    int? maxParticipants,
    int? currentParticipants,
    bool? isActive,
    String? imageUrl,
  }) {
    return EventItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() => 'EventItem(id: $id, title: $title)';
}
