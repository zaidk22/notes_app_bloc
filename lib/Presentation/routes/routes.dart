
import 'package:auto_route/auto_route.dart';
import 'package:notes_app_bloc/Presentation/routes/routes.gr.dart';



@AutoRouterConfig(  replaceInRouteName: "Page,Route",)      
class AppRouter extends $AppRouter {      
   
 @override      
 List<AutoRoute> get routes => [      
  AutoRoute(page: SplashRoute.page,initial: true),
  AutoRoute(page: SignInRoute.page),
    AutoRoute(page: NotesRoute.page)
  ];    
}