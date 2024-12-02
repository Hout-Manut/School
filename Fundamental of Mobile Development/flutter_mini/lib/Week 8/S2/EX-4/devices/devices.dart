enum SymbolDirection { before, after }

enum Device {

  usd(1, "\$", SymbolDirection.before), 
  khr(4100, "៛", SymbolDirection.after), 
  aud(1.5368, "\$", SymbolDirection.before),
  cad(1.4, "\$", SymbolDirection.before),
  cny(7.2392, "¥", SymbolDirection.before),
  eur(0.9471, "€", SymbolDirection.before), 
  jpy(150.19, "¥", SymbolDirection.before),
  thb(34.304, "฿", SymbolDirection.after),
  vnd(24000, "₫", SymbolDirection.after);

  const Device(this.multiplier, this.symbol, this.direction);

  final double multiplier;
  final String symbol;
  final SymbolDirection direction;

  double fromDollar(double dollar) => dollar * multiplier;
}