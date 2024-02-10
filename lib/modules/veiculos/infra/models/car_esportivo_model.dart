import 'package:equatable/equatable.dart';
import 'pneu_model.dart';

class CarEsportivoModel extends Equatable {
 final String cor;
 final String? arCondicionado;
 final PneuModel pneus;
 final List<String> bancos;
 final double valor;
 final List<String>? portas;

 const CarEsportivoModel ({
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
