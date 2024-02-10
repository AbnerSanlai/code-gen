import 'package:equatable/equatable.dart';
import 'pneu_entity.dart';

class CarEsportivoEntity extends Equatable {
 final String cor;
 final String? arCondicionado;
 final PneuEntity pneus;
 final List<String> bancos;
 final double valor;
 final List<String>? portas;

 const CarEsportivoEntity ({
   required this.cor,
   this.arCondicionado,
   required this.pneus,
   required this.bancos,
   required this.valor,
   this.portas,
 });

 @override
 List<Object?> get props => [
   cor,
   arCondicionado,
   pneus,
   bancos,
   valor,
   portas,
 ];
}
