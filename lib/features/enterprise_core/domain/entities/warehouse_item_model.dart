class EnterpriseWarehouseItem {
  const EnterpriseWarehouseItem({
    required this.id,
    required this.category,
    required this.name,
    required this.currentQuantity,
    required this.minimumQuantity,
    required this.incoming,
    required this.outgoing,
  });

  final String id;
  final String category;
  final String name;
  final int currentQuantity;
  final int minimumQuantity;
  final int incoming;
  final int outgoing;
}
