// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:milk_analysis/util/app_colors.dart';
// import 'package:milk_analysis/util/app_styles.dart';
// import 'package:milk_analysis/util/app_text_input_fields.dart';
// import 'package:provider/provider.dart';

// class CreateGroupDialog extends StatefulWidget{
//   const CreateGroupDialog({super.key});


//   @override
//   _createGroupState createState ()=> _createGroupState();
// }



// class _createGroupState  extends State<CreateGroupDialog>{

//   late final TextEditingController _titleController;
//   late final TextEditingController _groupLinkController;
//   late final TextEditingController _descriptionController;

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController();
//     _groupLinkController = TextEditingController();
//     _descriptionController = TextEditingController();

//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _groupLinkController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
    
//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<UserProvider, GroupProvider>(
//       builder: (context, valueU, valueG, child) {
        
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15),
//               topRight: Radius.circular(15),
//             )
//           ),

//           padding: EdgeInsets.only(
//               left: 20,
//               top: 10,
//               right: 20,
//               bottom: MediaQuery.of(context).viewInsets.bottom),


//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Container(
//                   width: 100,
//                   height: 3,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(2)
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20,),
//               const Center(
//                 child:Text(
//                 "Add Group",
//                 style: AppStyle.bigBoldBlackTextStyle,
//                 )),
//               const SizedBox(height: 20,),
//               const Text(
//                 "Title",
//                 style: AppStyle.normalBlackTextStyle,
//               ),

//               DSolidTextInputField(
//                 hintText: "Enter group title", 
//                 hintTextStyle: AppStyle.normalGreyTextStyle, 
//                 valueTextStyle: AppStyle.normalBlackTextStyle, 
//                 bgColor: AppColors.softWhiteColor, 
//                 borderRadius: 20, 
//                 btnHeight: 45, 
//                 controller: _titleController),

//               const SizedBox(height: 20,),
//               const Text(
//                 "Link",
//                 style: AppStyles.normalBlackTextStyle,
//               ),

//               DSolidTextInputField(
//                 hintText: "Enter Group link", 
//                 hintTextStyle: AppStyles.normalGreyTextStyle, 
//                 valueTextStyle: AppStyles.normalBlackTextStyle, 
//                 bgColor: AppColors.softWhiteColor, 
//                 borderRadius: 20, 
//                 btnHeight: 45, 
//                 controller: _groupLinkController),


//               const SizedBox(height: 20,),
//               const Text(
//                 "Description",
//                 style: AppStyles.normalBlackTextStyle,
//               ),

//               DSolidTextInputField(
//                 hintText: "Short group description", 
//                 hintTextStyle: AppStyles.normalGreyTextStyle, 
//                 valueTextStyle: AppStyles.normalBlackTextStyle, 
//                 bgColor: AppColors.softWhiteColor, 
//                 borderRadius: 20, 
//                 btnHeight: 45, 
//                 controller: _descriptionController),

//               const SizedBox(height: 50,),

//                isLoading? 
//                const Center(
//                 child: SizedBox(
//                   height: 30,
//                   width: 30,
//                   child:CircularProgressIndicator()),
//                ): DSolidButton(
//                 label: "Add Group", 
//                 btnHeight: 45, 
//                 bgColor: AppColors.primaryColor, 
//                 borderRadius: 20, 
//                 textStyle: AppStyles.normalWhiteTextStyle, 
//                 onClick: () => addGroup(
//                   userProvider: valueU, 
//                   groupProvider: valueG, 
//                   context: context))
//             ],
//           )
//         );
//       },);
//   }




//   Future<void> addGroup({
//     required UserProvider userProvider,
//     required GroupProvider groupProvider,
//     required BuildContext context
//   })async {

//     setState(() {
//       isLoading = true;
//     });

//     final res = await groupProvider.groupRepo.addGroup(
//       token: userProvider.token, 
//       group: GroupModule(
//         id: 0, 
//         title: _titleController.text, 
//         description: _descriptionController.text, 
//         coverImg: "thlfdfi0sdjfkdnfid9fsifjodsjfsfdsfsdncsfvjfov", 
//         doctorId: userProvider.doctorModule!.id, 
//         link: _groupLinkController.text));



//     setState(() {
//         isLoading = false;
//       });

//     if(res == 1){
//       Fluttertoast.showToast(
//         msg: "Group added succesfully");

//       Navigator.pop(context);
//       groupProvider.notifyAll();
//     }else if(res == -1){
//       Fluttertoast.showToast(
//         msg: "Unauthorized");
//     }else{
//       Fluttertoast.showToast(
//         msg: "Failed to Add group");
//     }
//   }
// }







// class AddArticleDialog extends StatefulWidget{
//   const AddArticleDialog({super.key});


//   @override
//   _AddArticleDialogState createState ()=> _AddArticleDialogState();
// }



// class _AddArticleDialogState  extends State<AddArticleDialog>{

//   late final TextEditingController _titleController;
//   late final TextEditingController _articleLinkController;
//   late final TextEditingController _descriptionController;
//   late final TextEditingController _coverImageLinkController;


//   bool isLoading = false;


//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController();
//     _articleLinkController = TextEditingController();
//     _descriptionController = TextEditingController();
//     _coverImageLinkController = TextEditingController();

//   }


//   @override
//   void dispose() {
//     _titleController.dispose();
//     _articleLinkController.dispose();
//     _descriptionController.dispose();
//     _coverImageLinkController.dispose();

//     super.dispose();
//   }
    
//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<UserProvider, ArticlesProvider>(
//       builder: (context, valueU, valueA, child) {
        
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15),
//               topRight: Radius.circular(15),
//             )
//           ),

//           padding: EdgeInsets.only(
//               left: 20,
//               top: 10,
//               right: 20,
//               bottom: MediaQuery.of(context).viewInsets.bottom),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Container(
//                   width: 100,
//                   height: 3,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(2)
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20,),
//               const Center(
//                 child:Text(
//                 "Add Article",
//                 style: AppStyles.bigBoldBlackTextStyle,
//                 )),
//               const SizedBox(height: 20,),
//               const Text(
//                 "Title",
//                 style: AppStyles.normalBlackTextStyle,
//               ),

//               DSolidTextInputField(
//                 hintText: "Enter Article title", 
//                 hintTextStyle: AppStyles.normalGreyTextStyle, 
//                 valueTextStyle: AppStyles.normalBlackTextStyle, 
//                 bgColor: AppColors.softWhiteColor, 
//                 borderRadius: 20, 
//                 btnHeight: 45, 
//                 controller: _titleController),

//               const SizedBox(height: 20,),
//               const Text(
//                 "Link",
//                 style: AppStyles.normalBlackTextStyle,
//               ),

//               DSolidTextInputField(
//                 hintText: "Enter Article link", 
//                 hintTextStyle: AppStyles.normalGreyTextStyle, 
//                 valueTextStyle: AppStyles.normalBlackTextStyle, 
//                 bgColor: AppColors.softWhiteColor, 
//                 borderRadius: 20, 
//                 btnHeight: 45, 
//                 controller: _articleLinkController),

//               const SizedBox(height: 20,),
//               const Text(
//                 "Cover Image Link",
//                 style: AppStyles.normalBlackTextStyle,
//               ),

//               DSolidTextInputField(
//                 hintText: "Cover image", 
//                 hintTextStyle: AppStyles.normalGreyTextStyle, 
//                 valueTextStyle: AppStyles.normalBlackTextStyle, 
//                 bgColor: AppColors.softWhiteColor, 
//                 borderRadius: 20, 
//                 btnHeight: 45, 
//                 controller: _coverImageLinkController),


//               const SizedBox(height: 20,),
//               const Text(
//                 "Description",
//                 style: AppStyles.normalBlackTextStyle,
//               ),

//               DSolidTextInputField(
//                 hintText: "Short article description", 
//                 hintTextStyle: AppStyles.normalGreyTextStyle, 
//                 valueTextStyle: AppStyles.normalBlackTextStyle, 
//                 bgColor: AppColors.softWhiteColor, 
//                 borderRadius: 20, 
//                 btnHeight: 45, 
//                 controller: _descriptionController),

//               const SizedBox(height: 50,),

//               isLoading? 
//                const Center(
//                 child: SizedBox(
//                   height: 30,
//                   width: 30,
//                   child:CircularProgressIndicator()),
//                ):DSolidButton(
//                 label: "Add Article", 
//                 btnHeight: 45, 
//                 bgColor: AppColors.primaryColor, 
//                 borderRadius: 20, 
//                 textStyle: AppStyles.normalWhiteTextStyle, 
//                 onClick: ()=> addArticle(
//                   userProvider: valueU, 
//                   articleProvider: valueA, context: context))
//             ],
//           )
//         );
//       },);
//   }


//   Future<void> addArticle({
//     required UserProvider userProvider,
//     required ArticlesProvider articleProvider,
//     required BuildContext context
//   })async{

//     setState(() {
//       isLoading  = true;
//     });

//     final res = await articleProvider.articlesRepo.addArticle(
//       token: userProvider.token, 
//       article: ArticleModule(
//         id: 0, 
//         content: _titleController.text, 
//         doctorId: "${userProvider.doctorModule!.id}", 
//         image:  _coverImageLinkController.text.isEmpty?
//          AppConstants.articlePlaceHolder: _coverImageLinkController.text, 
//         link: _articleLinkController.text));


//     setState(() {
//       isLoading  = false;
//     });

//     if(res == 1){
//       Fluttertoast.showToast(
//         msg: "Article added successful");
//       articleProvider.notifylAll();
//       Navigator.pop(context);
//     }else {
//       Fluttertoast.showToast(
//         msg: "Article not added");
//     }

//   }
// }






// class GroupViewDialog extends StatefulWidget{
//   final String groupTitle;
//   final String groupDescription;
//   final String groupLink;
//   const GroupViewDialog({
//     super.key,
//     required this.groupTitle,
//     required this.groupDescription,
//     required this.groupLink
//     });


//   @override
//   _GroupViewDialogState createState ()=> _GroupViewDialogState();
// }



// class _GroupViewDialogState  extends State<GroupViewDialog>{

//   @override
//   void initState() {
//     super.initState();

//   }
    
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15),
//           topRight: Radius.circular(15),
//         )
//       ),

//       padding: EdgeInsets.only(
//               left: 20,
//               top: 10,
//               right: 20,
//               bottom: MediaQuery.of(context).viewInsets.bottom),


//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Container(
//               width: 100,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(2)
//               ),
//             ),
//           ),
//           const SizedBox(height: 20,),
//           Center(
//             child:Text(
//               widget.groupTitle,
//               style: AppStyles.bigBoldBlackTextStyle,
//               )),
//           const SizedBox(height: 20,),
//           const Text(
//             "Link",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           Text(
//             widget.groupLink,
//             style: AppStyles.normalBlackTextStyle,
//           ),
//           const SizedBox(height: 20,),
//           const Text(
//             "Description",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           Text(
//             widget.groupDescription,
//             style: AppStyles.normalBlackTextStyle,
//           ),

//           const SizedBox(height: 50,),

//           DSolidButton(
//             label: "Join Group", 
//             btnHeight: 45, 
//             bgColor: AppColors.primaryColor, 
//             borderRadius: 20, 
//             textStyle: AppStyles.normalWhiteTextStyle, 
//             onClick: (){
//               launchUrl(Uri.parse(widget.groupLink));
//             })
//         ],
//       )
//     );
//   }
// }




// class BookingViewDialog extends StatefulWidget{
//   final String doctorName;
//   final String doctorEmail;
//   final String date;
//   final String time;
//   final String coverImg;
//   const BookingViewDialog({
//     super.key,
//     required this.doctorName,
//     required this.doctorEmail,
//     required this.date,
//     required this.time,
//     required this.coverImg
//     });


//   @override
//   _BookingViewDialogState createState ()=> _BookingViewDialogState();
// }



// class _BookingViewDialogState  extends State<BookingViewDialog>{

//   @override
//   void initState() {
//     super.initState();

//   }
    
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15),
//           topRight: Radius.circular(15),
//         )
//       ),

//       padding: EdgeInsets.only(
//               left: 20,
//               top: 10,
//               right: 20,
//               bottom: MediaQuery.of(context).viewInsets.bottom),


//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Container(
//               width: 100,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(2)
//               ),
//             ),
//           ),
//           const SizedBox(height: 20,),
          
//           SizedBox(
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: NetworkImage(
//                     "${AppConstants.imagesBase}${widget.coverImg}"),
//                 ),

//                 const SizedBox(width: 10,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.doctorName,
//                         style: AppStyles.normalBoldBlackTextStyle,
//                       ),
//                       const SizedBox(height: 2,),
//                       Text(
//                         widget.doctorEmail,
//                         style: AppStyles.smallBlackTextStyle,
//                       ),
//                     ],
//                   ))
//               ],
//             ),
//           ),

//           const SizedBox(height: 10,),
//           const Divider(thickness: 0.4, color: Colors.grey,),
//           const Text(
//             "Schedule Date",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           const SizedBox(height: 3,),
//           SizedBox(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.date,
//                     style: AppStyles.normalBlackTextStyle,
//                   ),),

//                 const SizedBox(width: 10,),
//                 Text(
//                   widget.time,
//                   style: AppStyles.normalBoldBlackTextStyle,
//                 ),
//                 const SizedBox(height: 5,),
//               ],
//             ),
//           ),

//           const SizedBox(height: 60,),

//           DSolidButton(
//             label: "Cancel", 
//             btnHeight: 45, 
//             bgColor: AppColors.primaryColor, 
//             borderRadius: 20, 
//             textStyle: AppStyles.normalWhiteTextStyle, 
//             onClick: (){}),
//           const SizedBox(height: 20,),
//         ],
//       )
//     );
//   }
// }




// class PatientViewDialog extends StatefulWidget{
//   final String patientName;
//   final String patientEmail;
//   final String nin;
//   final String phone;
//   final String coverImg;
//   const PatientViewDialog({
//     super.key,
//     required this.patientName,
//     required this.patientEmail,
//     required this.nin,
//     required this.phone,
//     required this.coverImg
//     });


//   @override
//   _PatientViewDialogState createState ()=> _PatientViewDialogState();
// }



// class _PatientViewDialogState  extends State<PatientViewDialog>{

//   @override
//   void initState() {
//     super.initState();

//   }
    
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15),
//           topRight: Radius.circular(15),
//         )
//       ),

//       padding: EdgeInsets.only(
//               left: 20,
//               top: 10,
//               right: 20,
//               bottom: MediaQuery.of(context).viewInsets.bottom),


//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Container(
//               width: 100,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(2)
//               ),
//             ),
//           ),
//           const SizedBox(height: 20,),
          
//           SizedBox(
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: AssetImage(widget.coverImg),
//                 ),

//                 const SizedBox(width: 10,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.patientName,
//                         style: AppStyles.normalBoldBlackTextStyle,
//                       ),
//                       const SizedBox(height: 2,),
//                       Text(
//                         widget.patientEmail,
//                         style: AppStyles.smallBlackTextStyle,
//                       ),
//                     ],
//                   ))
//               ],
//             ),
//           ),

//           const SizedBox(height: 10,),
//           const Divider(thickness: 0.4, color: Colors.grey,),
//           const Text(
//             "Phone",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           const SizedBox(height: 3,),
//           Text(
//             widget.phone,
//             style: AppStyles.normalBlackTextStyle,
//           ),

//           const SizedBox(height: 20,),
//           const Text(
//             "Nin",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           const SizedBox(height: 3,),
//           Text(
//             widget.nin,
//             style: AppStyles.normalBlackTextStyle,
//           ),

//           const SizedBox(height: 60,),

//           DSolidButton(
//             label: "Close", 
//             btnHeight: 45, 
//             bgColor: AppColors.primaryColor, 
//             borderRadius: 20, 
//             textStyle: AppStyles.normalWhiteTextStyle, 
//             onClick: (){}),
//           const SizedBox(height: 20,),
//         ],
//       )
//     );
//   }
// }





// class DoctorViewDialog extends StatefulWidget{
//   final String doctorName;
//   final String doctorEmail;
//   final String nin;
//   final String phone;
//   final String location;
//   final String coverImg;
//   final int doctorId;
//   const DoctorViewDialog({
//     super.key,
//     required this.doctorName,
//     required this.doctorEmail,
//     required this.nin,
//     required this.phone,
//     required this.location,
//     required this.coverImg,
//     required this.doctorId,
//     });


//   @override
//   _DoctorViewDialogState createState ()=> _DoctorViewDialogState();
// }



// class _DoctorViewDialogState  extends State<DoctorViewDialog>{

//   @override
//   void initState() {
//     super.initState();

//   }
    
//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<UserProvider, BookingProvider>(
//       builder:(context, valueU, valueB, child)
//        => Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15),
//           topRight: Radius.circular(15),
//         )
//       ),

//       padding: EdgeInsets.only(
//               left: 20,
//               top: 10,
//               right: 20,
//               bottom: MediaQuery.of(context).viewInsets.bottom),


//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Container(
//               width: 100,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(2)
//               ),
//             ),
//           ),
//           const SizedBox(height: 20,),
          
//           SizedBox(
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: AssetImage(widget.coverImg),
//                 ),

//                 const SizedBox(width: 10,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.doctorName,
//                         style: AppStyles.normalBoldBlackTextStyle,
//                       ),
//                       const SizedBox(height: 2,),
//                       Text(
//                         widget.doctorEmail,
//                         style: AppStyles.smallBlackTextStyle,
//                       ),
//                     ],
//                   ))
//               ],
//             ),
//           ),

//           const SizedBox(height: 10,),
//           const Divider(thickness: 0.4, color: Colors.grey,),
//           const Text(
//             "Phone",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           const SizedBox(height: 3,),
//           Text(
//             widget.phone,
//             style: AppStyles.normalBlackTextStyle,
//           ),

//           const SizedBox(height: 20,),
//           const Text(
//             "Nin",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           const SizedBox(height: 3,),
//           Text(
//             widget.nin,
//             style: AppStyles.normalBlackTextStyle,
//           ),

//           const SizedBox(height: 20,),
//           const Text(
//             "Location",
//             style: AppStyles.normalBoldBlackTextStyle,
//           ),
//           const SizedBox(height: 3,),
//           SizedBox(
//             child: Row(
//               children: [
//                 const Icon(Icons.location_on_outlined, color: Colors.red, size: 20,),
//                 const SizedBox(width: 10,),
//                 Text(
//                   widget.location,
//                   style: AppStyles.normalBlackTextStyle,
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 60,),

//           valueU.doctorModule != null? const SizedBox() :  DSolidButton(
//             label: "Book Session", 
//             btnHeight: 45, 
//             bgColor: AppColors.primaryColor, 
//             borderRadius: 20, 
//             textStyle: AppStyles.normalWhiteTextStyle, 
//             onClick: (){

//               showDatePicker(
//                 context: context, 
//                 firstDate: DateTime.now(), 
//                 lastDate: DateTime.now().add(Duration(days: 345),)).then(
//                   (xv){
//                     showTimePicker(
//                       context: context, 
//                       initialTime: TimeOfDay.now()).then(
//                         (time) async{
                          
//                           DateTime theDate = xv!.add(Duration(hours: time!.hour, minutes: time!.minute));
//                           // time.
                          
//                           // print("the Patient add to be added :::>>       ${valueU.patientModule!.id}");

                          
//                           print(">>>>>>>>>>>>>>>>>>>The booking date:  ${theDate.toString()}");

//                           final res = await valueB.bookingRepo.createBooking(
//                             token: valueU.token, 
//                             bookingModule: BookingModule(
//                               id: 0, 
//                               doctorId: widget.doctorId, 
//                               sessionDate: theDate.toString(), 
//                               patientId: valueU.patientModule!.id, 
//                               createAt: DateTime.now().toString(), 
//                               status: "Pending"));

//                           if(res == 1){
//                             Fluttertoast.showToast(
//                               msg: "Booking made successfully");
//                             valueB.notifyAll();
//                             Navigator.pop(context);
//                           }else{
//                             Fluttertoast.showToast(
//                               msg: "Booking failed");
//                           }


//                         });
//                   });

//               // showDialog(
//               //   context: context, 
//               //   builder:(context) => DatePickerDialog(
//               //     firstDate: DateTime.now(), 
//               //     lastDate: DateTime.now().add(Duration(days: 345),),
//               //     initialCalendarMode: DatePickerMode.day,
//               //     onDatePickerModeChange: (value) {
//               //       // showTimePicker(
//               //       //   context: context, 
//               //       //   initialTime: TimeOfDay.fromDateTime(DateTime.now()));      
//               //     },),
//               //     );
              
//             }),
//           const SizedBox(height: 20,),
//         ],
//       )
//     ),);
//   }
// }