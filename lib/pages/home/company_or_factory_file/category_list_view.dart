import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:theblue_crown/controllers/controller_lists/category_list_view_controller.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../../controllers/controller_lists/popular_product_controller.dart';
import '../../../utils/app_constants.dart';
import 'grid_view_of_popular_product.dart';
import 'grid_view_of_recommended_product.dart';

List<String> categoryIconList = [
  "assets/images/Popular-terminology.jpg",
  "assets/images/recommended-stamp-grunge-vintage-isolated-white-background-sign-148241010.jpg",
];
List<String> name = [
  'popular',
  'recommended',
];

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category List view
              GetBuilder<CategoryListViewController>(builder: (categoryListView) {
                  return Container(
                    color: Colors.white,

                    // child: SingleChildScrollView(
                    //   physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        height: Dimensions.height45 * Dimensions.height15 / 5 ,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryListView.categoryListViewList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: _selectedIndex == index ?
                              SelectedCategoryItem(
                                name: categoryListView.categoryListViewList[index].name!,
                                backgroundColor: Colors.white,
                                icon: ClipOval(
                                  child: SizedBox(
                                    width: Dimensions.listViewImgSize,
                                    height: Dimensions.listViewImgSize,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      child: CachedNetworkImage(
                                        imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + categoryListView.categoryListViewList[index].img!,
                                        height: Dimensions.listViewImgSize,
                                        width:Dimensions.listViewImgSize,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(color: Colors.black12,),
                                        errorWidget: (context, url, error) => Container(
                                          color: Colors.black12,
                                          child: const Icon(Icons.error, color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ) :
                              UnSelectedCategoryItem(
                                name: categoryListView.categoryListViewList[index].name!,
                                backgroundColor: Colors.white,
                                icon: ClipOval(
                                  child: SizedBox(
                                    width: Dimensions.listViewImgSize,
                                    height: Dimensions.listViewImgSize,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      child: CachedNetworkImage(
                                        imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + categoryListView.categoryListViewList[index].img!,
                                        height: Dimensions.listViewImgSize,
                                        width:Dimensions.listViewImgSize,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(color: Colors.black12,),
                                        errorWidget: (context, url, error) => Container(
                                          color: Colors.black12,
                                          child: const Icon(Icons.error, color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    // ),
                  );
                }
              ),
              // Material List View
              SizedBox(
                height: Dimensions.screenHeight - Dimensions.bottomHeightBar * Dimensions.height30 / 9.5,

                child: _selectedIndex == 0 ?
                GridViewOfElMomtazLabsa(pageId: 0,) :
                GridViewOfSuperElMomtazLabsa(pageId: 0,),
              ),
            ],
          );
        }
      );
  }
}

class SelectedCategoryItem extends StatelessWidget {
  const SelectedCategoryItem(
      {Key? key,
        required this.icon,
        required this.name,
        required this.backgroundColor
      })
      : super(key: key);

  final Widget icon;
  final String name;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.blue,
            child: CircleAvatar(
              radius: 33,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: backgroundColor,
                child: icon,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10,),
          Text(
            name,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class UnSelectedCategoryItem extends StatelessWidget {
  const UnSelectedCategoryItem(
      {Key? key,
        required this.icon,
        required this.name,
        required this.backgroundColor})
      : super(key: key);

  final Widget icon;
  final String name;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 33,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: backgroundColor,
                child: icon,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10,),
          Text(
            name,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}