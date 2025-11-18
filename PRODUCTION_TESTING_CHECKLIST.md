# Production Testing Checklist

## Pre-Deployment Verification

### ✅ Backend Dependencies
- [x] `express` - Web framework
- [x] `bcryptjs` - Password hashing
- [x] `jsonwebtoken` - JWT authentication
- [x] `sqlite3` - Database
- [x] `cors` - CORS middleware
- [x] `helmet` - Security headers
- [x] `express-rate-limit` - Rate limiting
- [x] `express-validator` - Input validation
- [x] `compression` - Response compression
- [x] `dotenv` - Environment variables
- [x] `imagekit` - Image upload/management
- [x] `multer` - File upload handling
- [x] `uuid` - Unique ID generation

### ✅ Frontend Dependencies
- [x] `next` - React framework
- [x] `react` & `react-dom` - React core
- [x] `@tanstack/react-query` - Data fetching
- [x] `axios` - HTTP client
- [x] `zustand` - State management
- [x] `framer-motion` - Animations
- [x] `lucide-react` - Icons
- [x] `react-hot-toast` - Toast notifications
- [x] `react-hook-form` - Form handling
- [x] `recharts` - Charts/analytics
- [x] `@radix-ui/*` - UI primitives
- [x] `tailwindcss` - Styling
- [x] `typescript` - Type safety

## Core Functionality Tests

### 🔐 Authentication & Authorization
- [ ] User registration works
- [ ] User login works
- [ ] JWT token generation and validation
- [ ] Protected routes require authentication
- [ ] Admin routes require admin role
- [ ] Logout clears session
- [ ] Token expiration handling
- [ ] Password hashing works correctly

### 🏠 Property Management
- [ ] List all properties (paginated)
- [ ] Filter properties by category (Residential/Commercial)
- [ ] Search properties by keyword
- [ ] Sort properties (newest, price, area)
- [ ] View property details
- [ ] Admin can create property
- [ ] Admin can edit property
- [ ] Admin can delete property
- [ ] Property images/videos/floor plans display correctly
- [ ] Media upload to ImageKit works
- [ ] Property status updates (Active/Sold/Rented/Inactive)

### 🔍 Search & Filters
- [ ] Smart search bar works
- [ ] Dynamic filters based on property category
- [ ] Residential filters (BHK, Bathrooms, Area, Furnishing)
- [ ] Commercial filters (Area, Price, Suitable For, Power Load, Parking)
- [ ] Filter persistence across page navigation
- [ ] Clear filters functionality
- [ ] Active filters summary display

### ❤️ Wishlist
- [ ] Add property to wishlist (authenticated)
- [ ] Remove property from wishlist
- [ ] View wishlist page
- [ ] Login modal triggers for unauthenticated users
- [ ] Toast notification on wishlist actions

### 📧 Leads & Inquiries
- [ ] Submit property inquiry form
- [ ] Inquiry form validation
- [ ] Contact details display correctly (+91 7337058554, agnijwala202222@gmail.com)
- [ ] Admin can view all leads
- [ ] Admin can update lead status
- [ ] Admin can delete leads
- [ ] Lead notifications/emails (if configured)

### 👥 User Management (Admin)
- [ ] View all users
- [ ] Filter users by role
- [ ] Search users
- [ ] Update user status (active/inactive)
- [ ] Update user role
- [ ] Delete users
- [ ] Export users to CSV

### 📊 Analytics (Admin)
- [ ] Dashboard statistics load correctly
- [ ] Views trend chart displays
- [ ] Leads trend chart displays
- [ ] Lead status breakdown chart
- [ ] Top properties by views
- [ ] Location statistics
- [ ] Date range filtering (7d, 30d, 90d, all)

### ⚙️ Settings (Admin)
- [ ] Profile info tab works
- [ ] Branding tab works
- [ ] Logo upload functionality
- [ ] Logo displays in Navbar
- [ ] Logo size and positioning correct
- [ ] Security tab (password change)
- [ ] Settings persist to database

### 🎨 UI/UX Features
- [ ] Responsive design (mobile, tablet, desktop)
- [ ] Navbar collapses on mobile
- [ ] Property grid responsive (1/2/3 columns)
- [ ] Loading states (spinners/skeletons)
- [ ] Toast notifications work
- [ ] Smooth animations (60FPS)
- [ ] No horizontal scroll on any breakpoint
- [ ] Consistent padding and spacing
- [ ] Card heights uniform
- [ ] Images lazy load correctly

### 🗺️ Additional Features
- [ ] Property map displays location
- [ ] Related properties section
- [ ] Property comparison feature
- [ ] Amenities display as pills
- [ ] Floor plans display correctly (images and PDFs)
- [ ] Media gallery (videos, images, floor plans in single container)
- [ ] Video playback works

## Performance Tests

### ⚡ Frontend Performance
- [ ] Lighthouse Performance score ≥ 90
- [ ] Lighthouse Accessibility score ≥ 90
- [ ] Lighthouse SEO score ≥ 90
- [ ] First Contentful Paint < 1.8s
- [ ] Time to Interactive < 3.8s
- [ ] Images optimized (Next.js Image component)
- [ ] Code splitting works
- [ ] No console errors in production
- [ ] Bundle size optimized

### ⚡ Backend Performance
- [ ] API response times < 200ms (average)
- [ ] Database queries optimized
- [ ] Rate limiting works correctly
- [ ] Compression enabled
- [ ] CORS configured correctly
- [ ] Security headers present

## Security Tests

### 🔒 Security Checks
- [ ] SQL injection prevention
- [ ] XSS protection
- [ ] CSRF protection
- [ ] Authentication tokens secure
- [ ] Password hashing (bcrypt)
- [ ] Rate limiting active
- [ ] Helmet security headers
- [ ] Input validation on all forms
- [ ] File upload validation
- [ ] Admin routes protected

## Production Environment Tests

### 🌐 Deployment
- [ ] Environment variables configured
- [ ] Database connection works
- [ ] ImageKit credentials valid
- [ ] PM2 process manager configured
- [ ] Nginx reverse proxy configured
- [ ] SSL certificate installed
- [ ] Domain DNS configured
- [ ] GitHub Actions deployment works
- [ ] Auto-deployment on push to main

### 📦 Build Process
- [ ] Frontend builds without errors (`npm run build`)
- [ ] Backend starts without errors
- [ ] No TypeScript errors
- [ ] No ESLint errors
- [ ] All imports resolve correctly
- [ ] Production build optimized

## Browser Compatibility

### 🌍 Browser Tests
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)
- [ ] Mobile browsers (iOS Safari, Chrome Mobile)

## Known Issues & Fixes

### ✅ Completed Fixes
- [x] Schedule visit feature removed
- [x] Media consolidated (videos, images, floor plans in single container)
- [x] Property delete option added in admin panel
- [x] Amenity delete functionality added
- [x] Analytics page fixed and functional
- [x] Fixed bottom bar removed from property details
- [x] Property details moved below description
- [x] Floor plan images fixed
- [x] Contact details updated
- [x] Logo upload fully functional
- [x] Signature upload removed
- [x] Logo size increased and visible on user pages

## Post-Deployment Monitoring

### 📈 Monitoring Checklist
- [ ] Error logging configured
- [ ] Performance monitoring active
- [ ] Database backups scheduled
- [ ] Uptime monitoring configured
- [ ] Alert system for critical errors

## Testing Commands

```bash
# Frontend build test
cd frontend
npm run build

# Backend start test
cd backend
npm start

# Type checking
cd frontend
npm run type-check

# Linting
cd frontend
npm run lint

# Production start (PM2)
npm run pm2:start
```

## Notes

- All features should be tested in production-like environment
- Test with real data volumes
- Verify all API endpoints respond correctly
- Check mobile responsiveness on actual devices
- Verify all images load from ImageKit
- Test with slow network conditions
- Verify error handling and user feedback

