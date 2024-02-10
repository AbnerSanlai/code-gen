import 'package:equatable/equatable.dart';

class PneuEntity extends Equatable {
 final String marca;
 final String cor;
 final double valor;

 const PneuEntity ({
   required this.marca,
   required this.cor,
   required this.valor,
 });

 @override
 List<Object?> get props => [
   marca,
   cor,
   valor,
 ];
}
