import 'package:eagri_pro/core/utils/usecase.dart';
import 'package:eagri_pro/features/configuration/domain/usecases/get_departement_by_region_usecase.dart';
import 'package:eagri_pro/features/configuration/domain/usecases/get_localite_by_sousprefecture_usecase.dart';
import 'package:eagri_pro/features/configuration/domain/usecases/get_resgions_usecase.dart';
import 'package:eagri_pro/features/configuration/domain/usecases/get_sousprefecture_by_departement_usecase.dart';
import 'package:get/get.dart';
import '../../../../injection_container.dart';
import '../../data/models/location_model.dart';

class SelectLocationController extends GetxController {
  var isLoadRegion = false.obs;
  var isLoadDepartement = false.obs;
  var isLoadSp = false.obs;
  var isLoadLocalite = false.obs;
  var listRegion = <RegionModel>[].obs;
  var listRegionShow = <RegionModel>[].obs;
  var listDepartement = <DepartementModel>[].obs;
  var listDepartementShow = <DepartementModel>[].obs;
  var listSp = <SpModel>[].obs;
  var listSpShow = <SpModel>[].obs;
  var listLocalite = <LocaliteModel>[].obs;
  var listLocaliteShow = <LocaliteModel>[].obs;
  GetResgionsUsecase getRegionsUsecase =
      GetResgionsUsecase(repository: di());
  GetDepartementByRegionUsecase getDepartementByRegionUsecase = GetDepartementByRegionUsecase(repository: di());
  GetSousprefectureByDepartementUsecase getSousprefectureByDepartementUsecase = GetSousprefectureByDepartementUsecase(repository: di());
  GetLocaliteBySousprefectureUsecase getLocaliteBySousprefectureUsecase = GetLocaliteBySousprefectureUsecase(repository: di());

  @override
  onInit() {
    getListRegion();
    super.onInit();
  }

  getListRegion() async {
    isLoadRegion.value = true;
    listRegion.value = [];
    listRegionShow.value = [];
    await getRegionsUsecase.call(NoParams()).then((value) {
      value.fold((failure) {}, (data) {
        listRegion.value = data;
        listRegionShow.value = data;
      });
      isLoadRegion.value = false;
    });
  }

  getListDepartement(int idRegion) async {
    isLoadDepartement.value = true;
    listDepartement.value = [];
    listDepartementShow.value = [];
    await getDepartementByRegionUsecase
        .call(idRegion).then((value) {
      value.fold((failure) {}, (data) {
        listDepartement.value = data;
        listDepartementShow.value = data;
      });
      isLoadDepartement.value = false;
    });
  }

  getListSp(int idDepartement) async {
    isLoadSp.value = true;
    listSp.value = [];
    listSpShow.value = [];
    await getSousprefectureByDepartementUsecase
        .call(idDepartement)
        .then((value) {
      value.fold((failure) {}, (data) {
        listSp.value = data;
        listSpShow.value = data;
      });
      isLoadSp.value = false;
    });
  }

  getListLocalite(int isSp) async {
    isLoadLocalite.value = true;
    listLocalite.value = [];
    listLocaliteShow.value = [];
    await getLocaliteBySousprefectureUsecase
        .call(isSp).then((value) {
      value.fold((failure) {}, (data) {
        listLocalite.value = data;
        listLocaliteShow.value = data;
      });
      isLoadLocalite.value = false;
    });
  }
}
