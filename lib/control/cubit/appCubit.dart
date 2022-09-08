import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user_model.dart';
import '../remote/dio_helper.dart';
import '../remote/end_points.dart';
import 'appStates.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIniState());

  static AppCubit get(context) => BlocProvider.of(context);

  DataModel? dataModel;
  List<Users> filteredUsers = [];
  getUsersData() async {
    emit(GetUserLoadingState());
    await DioHelper.getData(
      url: USER,
    ).then((value) {
      dataModel = DataModel.fromJson(value!.data);
      print(dataModel!.total);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      if (error is DioError) {
        print(error.toString());
        emit(GetUserErrorState());
      }
    });
  }

  filterUsers({required String text}){
    emit(SearchUserLoadingState());

    if(dataModel != null){
          if(text == ''){
      filteredUsers = dataModel!.users;
    }else{
            filteredUsers = dataModel!.users.where((element) => element.firstName.toLowerCase().startsWith(text)).toList();
    }
      emit(SearchUserSuccessState());
    }else{
      emit(SearchUserErrorState());
    }
  }


}
