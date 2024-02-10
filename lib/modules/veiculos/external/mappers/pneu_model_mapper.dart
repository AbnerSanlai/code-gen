import '../../infra/models/pneu_model.dart';

class PneuModelMapper {
 PneuModel ({
 required Map<String, dynamic> map, 
}) {
 return PneuModel (
marca: map['marca'],
cor: map['cor'],
valor: map['valor'],
}
