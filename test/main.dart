
import 'test.dart';

void main()async{
  final sql = SqliteHelper();
  sql.open();
  Map<String, dynamic> mp = {};
//  var mp = new Map<String,dynamic>();
  mp["id"] = '1';
  mp['name'] = 'ACkingdom';
  mp['account']='1074143281';
  mp['password']='123456';
  mp['gender']='man';
  mp['birthday']='123';
  mp['gameTotal']=0;
  mp['gameWin']=0;
  mp['gameFailure']=0;
  mp['gameMoney']=0;
//  print(mp.runtimeType);
//  print('ba'+ mp.runtimeType.toString());
  sql.insert(mp);
  print(sql.findAll());
//有rawQuery等函数自行点开看用自己需要的
}