class EndPoint {
  static String baseUrl = "https://kemet-gp2024.onrender.com/api/v1/";
  static String verifyEmail = "auth/verifyEmail";
  static String checkConformingEmail = "auth/checkConformingEmail";
  static String setingPassword = "auth/setingPassword";
  static String signup = "auth/signup";
  static String signin = "auth/signin";
  static String forgettingPassword = "auth/forgettingPassword";
  static String checkpinCode = "auth/checkpinCode";
  static String resetPassword = "auth/resetPassword";
  static String changePassword = "auth/changePassword";
  static String profile = "auth/profile";
  static String governrates = "governrates?sort=createdAt";
    static String offers = "offers";
  static String getChangePasswordEndPoint =
      "https://kemet-gp2024.onrender.com/api/v1/auth/changePassword";
  static String logoutEndpoint =
      "https://kemet-gp2024.onrender.com/api/v1/auth/logOut";


            static String ticketsList =
      "https://kemet-gp2024.onrender.com/api/v1/MyTickets";

  static String createOrder(myTicketId) {
    return "https://kemet-gp2024.onrender.com/api/v1/order/createCashOrder/$myTicketId";
  }

 static String createOnlineOrder(myTicketId) {
    return "https://kemet-gp2024.onrender.com/api/v1/order/checkOut/$myTicketId";
  }

    static String deleteTicket(TId) {
    return "https://kemet-gp2024.onrender.com/api/v1/MyTickets/$TId";
  }

      static String quantityTicket(TId) {
    return "https://kemet-gp2024.onrender.com/api/v1/MyTickets/$TId";
  }

  static String tourismWishList =
      "https://kemet-gp2024.onrender.com/api/v1/tourismPlaceWL/getLoggedUserWishList";

  static String deleteTourismWishList(favCard) {
    return "https://kemet-gp2024.onrender.com/api/v1/tourismPlaceWL/removeFromWishList/$favCard";
  }

  static String tripsWishList =
      "https://kemet-gp2024.onrender.com/api/v1/tripWL/getLoggedUserWishList";

  static String deleteTripWishList(favCard) {
    return "https://kemet-gp2024.onrender.com/api/v1/tripWL/removeFromWishList/$favCard";
  }

  static String legendWishList =
      "https://kemet-gp2024.onrender.com/api/v1/legendWL/getLoggedUserWishList";

  static String deleteLegendWishList(favCard) {
    return "https://kemet-gp2024.onrender.com/api/v1/legendWL/removeFromWishList/$favCard";
  }

  

}

class ApiKey {
    static String stripeUrl ="url";
     static String stack = "stack";
       static String status = "status";
  static String errorMessage = "ErrorMessage";

  static String error = "error";
  static String email = "email";
  static String pinCode = "pinCode";
  static String password = "password";
  static String rePassword = "rePassword";
  static String newPassword = "newPassword";
  static String token = "token";
  static String msg = "msg";
    static String message = "message";
 static String id = "id";
  static String TId = "_id";
  static String userId = "userId";
  static String user = "user";
  static String name = "name";
  static String image = "image";
    static String governorateId = "_id";
 static String legendId = "_id";
  static String tourismId = "_id";
  static String idgovernrate = "_id";
  static String title = "title";
  static String description = "description";
  static String quantity = "quantity";
  static String price = "price";
  static String imgCover = "imgCover";
  static String phone = "phone";
  static String firstName = "firstName";
  static String lastName = "lastName";
  static String DOB = "DOB";
  static String city = "city";
  static String profileImg = "profileImg";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profilePic";
}
