# 🏠 Solomon Realty - Luxury Real Estate Platform

A modern, responsive real estate platform built with Next.js and Express.js.

## 🚀 Features

- **Property Listings**: Browse and search properties with advanced filters
- **Property Details**: Comprehensive property information with images, videos, and floor plans
- **User Authentication**: Secure login and registration system
- **Wishlist**: Save favorite properties
- **Admin Dashboard**: Complete property and user management
- **Analytics**: Detailed analytics and insights
- **Responsive Design**: Works seamlessly on all devices
- **Image Optimization**: Powered by ImageKit CDN

## 🛠️ Tech Stack

### Frontend
- **Next.js 14** - React framework
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **Framer Motion** - Animations
- **React Query** - Data fetching
- **Zustand** - State management

### Backend
- **Express.js** - Node.js framework
- **SQLite** - Database
- **JWT** - Authentication
- **ImageKit** - Image hosting
- **Helmet** - Security

## 📦 Installation

### Prerequisites
- Node.js 18+ 
- npm 9+

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/solomon-reality.git
   cd solomon-reality
   ```

2. **Install dependencies**
   ```bash
   # Backend
   cd backend
   npm install
   
   # Frontend
   cd ../frontend
   npm install
   ```

3. **Configure environment variables**
   
   Create `backend/.env`:
   ```env
   NODE_ENV=development
   PORT=5000
   JWT_SECRET=your-secret-key
   DATABASE_URL=./database.sqlite
   IMAGEKIT_PUBLIC_KEY=your-key
   IMAGEKIT_PRIVATE_KEY=your-key
   IMAGEKIT_URL_ENDPOINT=your-endpoint
   CORS_ORIGIN=http://localhost:3000
   ```
   
   Create `frontend/.env.local`:
   ```env
   NEXT_PUBLIC_API_URL=http://localhost:5000/api
   ```

4. **Start development servers**
   ```bash
   # Terminal 1 - Backend
   cd backend
   npm run dev
   
   # Terminal 2 - Frontend
   cd frontend
   npm run dev
   ```

5. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000/api

## 🚀 Production Deployment

See [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) for complete deployment instructions.

Quick deployment steps:
1. Setup Digital Ocean Droplet
2. Install Node.js, PM2, Nginx
3. Clone repository
4. Configure environment variables
5. Setup PM2 and Nginx
6. Configure SSL
7. Setup GitHub Actions for CI/CD

## 📁 Project Structure

```
solomon-reality/
├── backend/
│   ├── config/          # Database configuration
│   ├── middleware/      # Auth, security middleware
│   ├── routes/          # API routes
│   ├── utils/           # Helper functions
│   └── server.js        # Express server
├── frontend/
│   ├── src/
│   │   ├── app/         # Next.js pages
│   │   ├── components/  # React components
│   │   ├── lib/         # Utilities and API client
│   │   └── store/       # Zustand stores
│   └── public/          # Static assets
├── ecosystem.config.js  # PM2 configuration
├── nginx.conf           # Nginx configuration
├── deploy.sh            # Deployment script
└── .github/
    └── workflows/
        └── deploy.yml   # GitHub Actions CI/CD
```

## 🔐 Environment Variables

### Backend (.env)
- `NODE_ENV` - Environment (development/production)
- `PORT` - Backend port (default: 5000)
- `JWT_SECRET` - Secret for JWT tokens
- `DATABASE_URL` - SQLite database path
- `IMAGEKIT_PUBLIC_KEY` - ImageKit public key
- `IMAGEKIT_PRIVATE_KEY` - ImageKit private key
- `IMAGEKIT_URL_ENDPOINT` - ImageKit URL endpoint
- `CORS_ORIGIN` - Allowed CORS origin

### Frontend (.env.local)
- `NEXT_PUBLIC_API_URL` - Backend API URL

## 📝 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/profile` - Get user profile
- `PUT /api/auth/profile` - Update profile

### Properties
- `GET /api/properties` - Get all properties (with filters)
- `GET /api/properties/:id` - Get property details
- `POST /api/properties` - Create property (admin)
- `PUT /api/properties/:id` - Update property (admin)
- `DELETE /api/properties/:id` - Delete property (admin)

### Wishlist
- `GET /api/wishlist` - Get user wishlist
- `POST /api/wishlist` - Add to wishlist
- `DELETE /api/wishlist/:id` - Remove from wishlist

### Admin
- `GET /api/admin/dashboard` - Dashboard stats
- `GET /api/admin/users` - Get all users
- `GET /api/admin/analytics` - Get analytics
- `GET /api/admin/settings` - Get settings
- `PUT /api/admin/settings` - Update settings

## 🧪 Scripts

### Backend
```bash
npm start      # Start production server
npm run dev    # Start development server with nodemon
```

### Frontend
```bash
npm run dev    # Start development server
npm run build  # Build for production
npm start      # Start production server
npm run lint   # Run ESLint
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the ISC License.

## 👥 Authors

- Your Name - Initial work

## 🙏 Acknowledgments

- ImageKit for image hosting
- Next.js team for the amazing framework
- All contributors and users

---

**Made with ❤️ for the real estate industry**

