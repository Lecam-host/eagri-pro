enum Routes {
  // Core Routes
  initial('/', ''),
  home('/home', 'home'),
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
  detailsOrders('/details-orders', 'details-orders'),
  cart('/cart', 'cart'),
  favorites('/favorites', 'favorites'),
  notifications('/notifications', 'notifications'),
  settings('/settings', 'settings'),

  // Onboarding
  onBoarding('/onboarding', 'onboarding'),
  splash('/splash', 'splash');

  final String path;
  final String name;
  const Routes(this.path, this.name);
}
