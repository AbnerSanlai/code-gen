import '../../infra/models/car_esportivo_model.dart';
import 'pneu_model_mapper.dart';

class CarEsportivoModelMapper {
final PneuModelMapper _pneuModelMapper;

 const CarEsportivoModelMapper ({
     required PneuModelMapper pneuModelMapper,
 })  : 
     _pneuModelMapper = pneuModelMapper;
 CarEsportivoModel ({
 required Map<String, dynamic> map, 
}) {
 return CarEsportivoModel (
cor: map['cor'],
arCondicionado: map['arCondicionado'],
pneus: map['pneus'],
   bancos: map['bancos'] == null ? null : (map['bancos'] as List).map((map) {
     return _stringModelMapper.fromMap(map: map);
   }).toList(),
bancos: map['bancos'],
valor: map['valor'],
   portas: map['portas'] == null ? null : (map['portas'] as List).map((map) {
     return _string>ModelMapper.fromMap(map: map);
   }).toList(),
portas: map['portas'],
}
