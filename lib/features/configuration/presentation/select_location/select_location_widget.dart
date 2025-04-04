import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/select_search_field.dart';
import '../../../../core/constants/color_constants.dart';
import '../../data/models/location_model.dart';
import 'select_location_controller.dart';


class SelectLocationWidget extends StatefulWidget {
  const SelectLocationWidget({super.key, required this.onChanged});
  final Function(SelectLocationResultat) onChanged;
  @override
  State<SelectLocationWidget> createState() => _SelectLocationWidgetState();
}

class _SelectLocationWidgetState extends State<SelectLocationWidget> {
  SelectLocationController controller = Get.put(SelectLocationController());
  RegionModel? regionSelected;

  LocaliteModel? localiteSelected;
  SpModel? sousPrefectureSelected;
  DepartementModel? departementSelected;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.listRegion.isNotEmpty)
            DropdownSearch<RegionModel>(
              decoratorProps:
                  dropDownDecoratorPropsCustom("Choisir une region", context),
              compareFn: (item, selectedItem) => item.id == selectedItem.id,
              validator: (p0) {
                if (p0 == null) {
                  return "Veuillez choisir une region";
                }
                return null;
              },
              items: (filter, infiniteScrollProps) =>
                  controller.listRegionShow.map(
                (RegionModel value) {
                  return value;
                },
              ).toList(),
              dropdownBuilder: (context, selectedItem) {
                if (selectedItem == null) {
                  return SizedBox.shrink();
                }

                return ElementListTile(
                  title: selectedItem.name,
                );
              },
              onChanged: (value) {
                setState(() {
                  regionSelected = value;
                });
                widget.onChanged(SelectLocationResultat(
                  region: value!,
                ));
                controller.getListDepartement(value.id);
              },
              popupProps: PopupProps.menu(
                constraints: constraintsSelectFieldCustom(context),
                searchFieldProps: TextFieldProps(
                  decoration: decorationSelectFieldCustom,
                  onChanged: (value) {
                    controller.listRegionShow.value = controller.listRegion
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  },
                ),
                disableFilter: true, //data will be filtered by the backend
                showSearchBox: true,
                showSelectedItems: true,
                searchDelay: Duration(milliseconds: 100),
                itemBuilder: (ctx, item, isDisabled, isSelected) {
                  return ElementListTile(
                    title: item.name,
                    isSelected: isSelected,
                  );
                },
              ),
            ),
          if (controller.listDepartementShow.isNotEmpty) ...[
            SizedBox(height: 10),
            DropdownSearch<DepartementModel>(
              decoratorProps: dropDownDecoratorPropsCustom(
                  "Choisir un departement", context),
              compareFn: (item, selectedItem) => item.id == selectedItem.id,
              validator: (p0) {
                if (p0 == null) {
                  return "Veuillez choisir un departement";
                }
                return null;
              },
              items: (filter, infiniteScrollProps) =>
                  controller.listDepartementShow.map(
                (DepartementModel value) {
                  return value;
                },
              ).toList(),
              dropdownBuilder: (context, selectedItem) {
                if (selectedItem == null) {
                  return SizedBox.shrink();
                }

                return ElementListTile(
                  title: selectedItem.name,
                );
              },
              onChanged: (value) {
                setState(() {
                  departementSelected = value;
                });
                widget.onChanged(SelectLocationResultat(
                  region: regionSelected,
                  departement: departementSelected,
                ));
                controller.getListSp(value!.id);
              },
              popupProps: PopupProps.menu(
                constraints: constraintsSelectFieldCustom(context),
                searchFieldProps: TextFieldProps(
                  decoration: decorationSelectFieldCustom,
                  onChanged: (value) {
                    controller.listDepartementShow.value = controller
                        .listDepartement
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  },
                ),
                disableFilter: true, //data will be filtered by the backend
                showSearchBox: true,
                showSelectedItems: true,
                searchDelay: Duration(milliseconds: 100),
                itemBuilder: (ctx, item, isDisabled, isSelected) {
                  return ElementListTile(
                    title: item.name,
                    isSelected: isSelected,
                  );
                },
              ),
            )
          ],
          if (controller.listSpShow.isNotEmpty) ...[
            SizedBox(height: 10),
            DropdownSearch<SpModel>(
              decoratorProps: dropDownDecoratorPropsCustom(
                  "Choisir une sous prefecture", context),
              compareFn: (item, selectedItem) => item.id == selectedItem.id,
              validator: (p0) {
                if (p0 == null) {
                  return "Veuillez choisir une sous prefecture";
                }
                return null;
              },
              items: (filter, infiniteScrollProps) => controller.listSpShow.map(
                (SpModel value) {
                  return value;
                },
              ).toList(),
              dropdownBuilder: (context, selectedItem) {
                if (selectedItem == null) {
                  return SizedBox.shrink();
                }

                return ElementListTile(
                  title: selectedItem.name,
                );
              },
              onChanged: (value) {
                setState(() {
                  sousPrefectureSelected = value;
                });
                widget.onChanged(SelectLocationResultat(
                  region: regionSelected!,
                  departement: departementSelected,
                  sousPrefecture: value,
                ));
                controller.getListLocalite(value!.id);
              },
              popupProps: PopupProps.menu(
                constraints: constraintsSelectFieldCustom(context),
                searchFieldProps: TextFieldProps(
                  decoration: decorationSelectFieldCustom,
                  onChanged: (value) {
                    controller.listSpShow.value = controller.listSp
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  },
                ),
                disableFilter: true, //data will be filtered by the backend
                showSearchBox: true,
                showSelectedItems: true,
                searchDelay: Duration(milliseconds: 100),
                itemBuilder: (ctx, item, isDisabled, isSelected) {
                  return ElementListTile(
                    title: item.name,
                    isSelected: isSelected,
                  );
                },
              ),
            )
          ],
          if (controller.listLocaliteShow.isNotEmpty) ...[
            SizedBox(height: 10),
            DropdownSearch<LocaliteModel>(
              decoratorProps:
                  dropDownDecoratorPropsCustom("Choisir une localité", context),
              compareFn: (item, selectedItem) => item.id == selectedItem.id,
              validator: (p0) {
                if (p0 == null) {
                  return "Veuillez choisir une localité";
                }
                return null;
              },
              items: (filter, infiniteScrollProps) =>
                  controller.listLocaliteShow.map(
                (LocaliteModel value) {
                  return value;
                },
              ).toList(),
              dropdownBuilder: (context, selectedItem) {
                if (selectedItem == null) {
                  return SizedBox.shrink();
                }

                return ElementListTile(
                  title: selectedItem.name,
                );
              },
              onChanged: (value) {
                setState(() {
                  localiteSelected = value;
                });
                widget.onChanged(SelectLocationResultat(
                  region: regionSelected!,
                  departement: departementSelected,
                  sousPrefecture: sousPrefectureSelected,
                  locality: value,
                ));
                controller.getListLocalite(value!.id);
              },
              popupProps: PopupProps.menu(
                constraints: constraintsSelectFieldCustom(context),
                searchFieldProps: TextFieldProps(
                  decoration: decorationSelectFieldCustom,
                  onChanged: (value) {
                    controller.listLocaliteShow.value = controller.listLocalite
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  },
                ),
                disableFilter: true, //data will be filtered by the backend
                showSearchBox: true,
                showSelectedItems: true,
                searchDelay: Duration(milliseconds: 100),
                itemBuilder: (ctx, item, isDisabled, isSelected) {
                  return ElementListTile(
                    title: item.name,
                    isSelected: isSelected,
                  );
                },
              ),
            )
          ],
        ],
      ),
    );
  }
}

class ElementListTile extends StatelessWidget {
  const ElementListTile({
    required this.title,
    this.isSelected = false,
    super.key,
  });
  final bool isSelected;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: ColorConstants.primaryColor,
          child: Text("${title[0]}${title[1]}")),
      selected: isSelected,
      title: Text(title),
    );
  }
}

class SelectLocationResultat {
  final RegionModel? region;

  final LocaliteModel? locality;
  final SpModel? sousPrefecture;
  final DepartementModel? departement;
  SelectLocationResultat(
      {this.locality, this.region, this.sousPrefecture, this.departement});
}
