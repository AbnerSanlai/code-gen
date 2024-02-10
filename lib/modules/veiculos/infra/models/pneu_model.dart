import 'package:equatable/equatable.dart';

class PneuModel extends Equatable {
 final String marca;
 final String cor;
 final double valor;

 const PneuModel ({
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
