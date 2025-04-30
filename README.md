# Shelf-life Bookstore Website

## Project Structure
The project is now organized for deployment on Vercel:

```
/
├── public/                 # All static files
│   ├── *.html              # HTML files
│   ├── css/                # CSS files
│   ├── js/                 # JavaScript files
│   └── assets/
│       └── images/         # Image files
├── package.json            # Node.js configuration
├── vercel.json             # Vercel deployment configuration
└── .vercelignore           # Files to ignore during deployment
```

## Deployment on Vercel

### Option 1: Deploy with Vercel CLI
1. Install Vercel CLI: `npm i -g vercel`
2. Run `vercel` in the project root
3. Follow the prompts to deploy

### Option 2: Deploy with Vercel Dashboard
1. Sign up for a Vercel account: https://vercel.com/signup
2. Create a new project and import from your Git repository
3. Use these deployment settings:
   - Framework Preset: Other
   - Build Command: None (leave empty)
   - Output Directory: public
   - Install Command: npm install

## Local Development
To preview the site locally:
1. Install dependencies: `npm install`
2. Run the development server: `npm start`
3. Open your browser to `http://localhost:3000`

## Troubleshooting
If you encounter any issues with images not loading:
1. Make sure all image paths in HTML files use the pattern `src="assets/images/filename.ext"`
2. Verify all CSS files are referenced as `href="css/filename.css"`
3. Check that all JS files are referenced as `src="js/filename.js"` 