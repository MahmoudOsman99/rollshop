import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/features/assembly_steps_feature/models/assembly_steps_model.dart';
import 'package:rollshop/features/main/chock_type_enum.dart';
import 'package:rollshop/features/main/model/chock_type_model.dart';
import 'package:rollshop/references/images_path.dart';

import '../../core/theme/styles.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<String> sectionsName = [
    "BDM",
    "TDM",
    "Vertical",
    "Straightener",
  ];
  List chockTypesNames = ChockTypeEnumDetailes.getNames();
  List chockTypes = ChockTypes.values;

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'assets/images/chock_types/${ChockTypes.BDS.name.toLowerCase()}.jpg');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BDM Section',
          style: MyTextStyles.font32WhiteBold,
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.mainBlue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView(
            children: [
              GridView.builder(
                itemCount: chockTypesNames.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                ),
                itemBuilder: (context, index) => SizedBox(
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(
                        Routes.chockDetailesScreen,
                        arguments: ChockTypesModel(
                          id: 'id',
                          name: 'Chock One',
                          chockImagePath: ImagesPath.bottomDriveSideImagePath,
                          notes: 'notes',
                          assemblySteps: [
                            AssemblyStepsModel(
                              id: "id",
                              description: "description",
                              stepsDetailes: [
                                StepsDetailesModel(
                                  description: 'description',
                                  imagesPath: [
                                    'assets/images/chock_types/bottom_thurst_chock.jpg',
                                    'assets/images/chock_types/bos.jpg',
                                  ],
                                  notes: "notes of assembly",
                                )
                              ],
                              notes: "notes of steps",
                            ),
                            AssemblyStepsModel(
                              id: "id",
                              description: "description",
                              stepsDetailes: [
                                StepsDetailesModel(
                                  description: 'description',
                                  imagesPath: [
                                    'assets/images/chock_types/bottom_thurst_chock.jpg',
                                    'assets/images/chock_types/bos.jpg',
                                  ],
                                  notes: "notes of assembly",
                                )
                              ],
                              notes: "notes of steps",
                            ),
                            AssemblyStepsModel(
                              id: "id",
                              description: "description",
                              stepsDetailes: [
                                StepsDetailesModel(
                                  description: 'description',
                                  imagesPath: [
                                    'assets/images/chock_types/bottom_thurst_chock.jpg',
                                    'assets/images/chock_types/bos.jpg',
                                  ],
                                  notes: "notes of assembly",
                                )
                              ],
                              notes: "notes of steps",
                            ),
                          ],
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Image.asset(
                                'assets/images/chock_types/bottom_thurst_chock.jpg',
                                // 'assets/images/chock_types/${chockTypes[index]}.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text("${chockTypesNames[index]}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "TDM",
                style: MyTextStyles.font32WhiteBold,
              ),
              Text(
                "Vertical",
                style: MyTextStyles.font32WhiteBold,
              ),
              Text(
                "Straightener",
                style: MyTextStyles.font32WhiteBold,
              ),
              Text(
                "Guides",
                style: MyTextStyles.font32WhiteBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
