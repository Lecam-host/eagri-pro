enum Routes {
  // Core Routes
  initial('/', ''),
  home('/home', 'home'),
  services('/services', 'services'),
  scanQrCode('/scan_qr_code', 'scan_qr_code'),
  market('/market', 'market'),
  profile('/profile', 'profile'),

  // Auth Routes
  login('/login', 'login'),
  register('/register', 'register'),
  verify('/verify', 'verify'),
  forgotPassword('/forgot-password', 'forgot-password'),
  updatePassword('/update-password', 'update-password'),

  // Feature Routes
  orders('/orders', 'orders'),
  product('/product', 'product'),
  detailsOrders('/details-orders', 'details-orders'),
  cart('/cart', 'cart'),
  favorites('/favorites', 'favorites'),
  notifications('/notifications', 'notifications'),
  settings('/settings', 'settings'),
  deliverySuccess('/delivery-success', 'delivery-success'),
  deliveryFailure('/delivery-failure', 'delivery-failure'),
  // Feature Client Routes
  selectClient('select-client', 'select-client'),
  dasboardClient('dasboard-client', 'dasboard-client'),

  // Feature Product Routes
  selectedProductPage('selected-product-page', 'selected-product-page'),
  publishFormProduct('publish-form-product', 'publish-form-product'),
  chooseTypePublication('choose-type-publication', 'choose-type-publication'),

  // Onboarding
  onBoarding('/onboarding', 'onboarding'),
  splash('/splash', 'splash');

  final String path;
  final String name;
  const Routes(this.path, this.name);
}
