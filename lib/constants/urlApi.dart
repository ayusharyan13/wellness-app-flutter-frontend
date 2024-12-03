class UrlApi {
  UrlApi._();
  static const baseUrl = "https://3be3-103-139-190-234.ngrok-free.app";

  //        ------ Authentication API ------------------
  static const authUrl = "$baseUrl/api/auth";

  static const urlSignUp = "$authUrl/signup";
  static const urlSignIn = "$authUrl/login";


  //        ------- Blog Posts API ---------
  static const postUrl = "$baseUrl/api/posts";

  // admin access
  static const urlCreatePost = postUrl;
  static const urlDeletePostById = "$postUrl/id";
  static const urlUpdatePostById = "$postUrl/id";

  // use pagination and sorting pathParameter
  static const urlGetAllPosts = postUrl;
  // handle get post by id:
  static const urlGetPostById = "$postUrl/id";
  // handle passing category id
  static const getPostsByCategoryId = "$postUrl/category";


  // booking apis

  static const getAvailableSlots = "$baseUrl/slots/available";
  static const getConfirmedBooking = "$baseUrl/appointments/confirmed";
  static const getPendingBooking = "$baseUrl/appointments/pending";
  static const getUpComingBooking = "$baseUrl/appointments/upcoming";
  static const getPreviousBooking = "$baseUrl/appointments/previous";

  static const createBooking = "$baseUrl/appointments/book";


  static const saltKey = 'de55c6d0-813e-4b38-b2f3-b94ef5b80af3';
  static const saltIndex = '1';
}