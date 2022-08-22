import 'calls_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator(){
  locator.registerSingleton(CallsAndMessagesService());
}