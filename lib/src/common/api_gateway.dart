class ApiGateway {
  // Address API
  static const getProvince = "";

  // Authentication API
  static const register = "auth/register";
  static const login = "auth/login";
  static const verify = "auth/verify";
  static const forgotPass = "auth/forgot-password";
  static const sendNewPass = "auth/send-password";
  static const getAuth = "auth/get-auth";

  // Post API
  //vehicle: xe cộ :))
  static const createPostCar = "post/create-post-car";
  static const craetePostMotorbike = "post/create-post-motorbike";
  static const createPostElecticBicycle = "post/create-post-bicycle";
  //BĐS
  static const createPostApartment = "post/create-post-apartment";
  static const createPostHouse = "post/create-post-house";
  static const createPostGround = "post/create-post-ground";
  static const createPostMotelRoom = "post/create-post-motelroom";
  static const createPostOffice = "post/create-post-office";

  // điện tử
  static const createPostLaptop = "post/create-post-laptop";
  static const createPostPhone = "post/create-post-phone";

  // Post Service
  static const getAllPostAuth = "post/get-list-post";
  static const getAllPost = "post/get-all-post";
  static const getPostDetailAPI = "post/get-detail-post";
  static const getPostOver = "post/get-list-post-over";
  static const updatePost = "post/update-post";
  static const reNewPost = "post/renew-post";
  static const getAllPostType = "post/get-all-post-type";
  static const getAllPostCategoryTech = "post/get-list-post-categorytech";
  static const getAllPostCategoryCar = "post/get-list-post-categorycar";
  static const getAllPostCategoryBDS = "post/get-list-post-categorybds";

  // payment Service
  static const paymentPaypal = "payment/order";
  static const paymentVNPay = "post/priority-post";
  static const vnPayRevenue = "vnpay/revenue";

  // Favorite post
  static const registerFavorite = "post/favorite";
  static const getAllPostFavorite = "post/get-list-favorite";
  static const cancelFavorite = "post/cancel-favorite";

  // Comment post
  static const createComment = "comments/create-comments";
  static const getCommentOfPost = "comments/get-comments";
  static const deleteComment = "comments/delete-comments";
}
