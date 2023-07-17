import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/admin_cubit/admin_states.dart';

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit() : super(AdminInitialState());
  static AdminCubit get(context) => BlocProvider.of(context) ;

  bool adminLoggedIn = false ;
  void logIn(){
    adminLoggedIn = true ;
    emit(AdminLoggedIn());
  }

  PanelServices service = PanelServices.editPersonal ;
  void changeShownPanelService(PanelServices pickedService){
    service = pickedService ;
    emit(AdminPickedService());
  }


}

enum PanelServices{
  editPersonal,
  addProject,
  editProject,
  closePanel,
}