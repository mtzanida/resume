# Maria Tzanidaki - Resume Website

This is a personal resume website showcasing my professional experience, skills, and projects.

## Features

- Responsive design using Tailwind CSS
- Dark theme with modern UI components
- Sections for skills, experience, projects, and certifications
- Contact information and social media links
- Mobile-friendly layout

## Detailed Setup Instructions

### Prerequisites

- Git installed on your local machine
- GitHub account
- Basic knowledge of HTML and CSS (for customization)

### Step 1: Clone the Repository

```bash
git clone https://github.com/mtzanida/resume.git
cd resume
```

### Step 2: Customize the Resume

1. Open `index.html` in your preferred code editor
2. Update the following sections with your information:
   - Header: Name and job title
   - About: Professional summary
   - Contact: Email, phone, location, and LinkedIn
   - Skills: Technical competencies
   - Experience: Work history and achievements
   - Projects: Notable projects and contributions
   - Education & Certifications: Academic background and professional certifications
3. Replace placeholder text and links with your actual information
4. Optionally, modify the styling in the `<style>` section or by editing Tailwind classes

### Step 3: Test Locally

Open the `index.html` file in your web browser to preview your changes:

```bash
# On macOS
open index.html

# On Windows
start index.html

# On Linux
xdg-open index.html
```

### Step 4: Deploy to GitHub Pages

#### Option 1: Using the GitHub UI

1. Push your changes to GitHub:
   ```bash
   git add .
   git commit -m "Update resume content"
   git push origin main
   ```

2. Go to your GitHub repository (https://github.com/mtzanida/resume)
3. Click on "Settings" > "Pages" in the left sidebar
4. Under "Source", select "Deploy from a branch"
5. Choose "main" branch and "/ (root)" folder
6. Click "Save"
7. Wait a few minutes for your site to be published
8. Your site will be available at `https://mtzanida.github.io/resume/`

#### Option 2: Using GitHub Actions (Automated Deployment)

This repository includes a GitHub Actions workflow that automatically deploys your site to GitHub Pages whenever you push changes to the main branch.

1. Push your changes to GitHub:
   ```bash
   git add .
   git commit -m "Update resume content"
   git push origin main
   ```

2. Go to your GitHub repository (https://github.com/mtzanida/resume)
3. Click on "Settings" > "Pages" in the left sidebar
4. Under "Source", select "GitHub Actions"
5. Your site will be automatically deployed when you push to the main branch
6. Your site will be available at `https://mtzanida.github.io/resume/`

### Step 5: Add a Custom Domain (Optional)

1. Purchase a domain from a domain registrar (e.g., Namecheap, GoDaddy)
2. Go to your GitHub repository settings > Pages
3. Under "Custom domain", enter your domain name and click "Save"
4. Configure your domain's DNS settings:
   - Add an A record pointing to GitHub Pages IP addresses:
     ```
     185.199.108.153
     185.199.109.153
     185.199.110.153
     185.199.111.153
     ```
   - Or add a CNAME record pointing to `mtzanida.github.io`
5. Wait for DNS propagation (may take up to 24 hours)

## Customization Tips

### Adding a Profile Picture

1. Add your profile image to the repository (e.g., `images/profile.jpg`)
2. Update the HTML to include your image in the header section:
   ```html
   <div class="flex items-center">
     <img src="images/profile.jpg" alt="Maria Tzanidaki" class="w-16 h-16 rounded-full mr-4">
     <div>
       <h1 class="text-3xl font-bold text-white">Maria Tzanidaki</h1>
       <p class="text-xl text-gray-400 mt-1">Cloud Engineer | AWS Certified Architect</p>
     </div>
   </div>
   ```

### Adding a Downloadable PDF Resume

1. Add your PDF resume to the repository (e.g., `assets/maria-tzanidaki-resume.pdf`)
2. Update the download button link:
   ```html
   <a href="assets/maria-tzanidaki-resume.pdf" class="inline-flex items-center px-4 py-2 border border-gray-700 rounded-md hover:bg-gray-800 bg-transparent text-white transition-colors" download>
     <i class="fas fa-download mr-2 w-4 h-4"></i>
     Download CV
   </a>
   ```

### Adding Google Analytics

Add the following code before the closing `</head>` tag:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=YOUR-GA-ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'YOUR-GA-ID');
</script>
```

Replace `YOUR-GA-ID` with your actual Google Analytics tracking ID.

## Maintenance

To update your resume in the future:

1. Make changes to the `index.html` file
2. Test locally to ensure everything looks correct
3. Commit and push your changes to GitHub:
   ```bash
   git add .
   git commit -m "Update resume content"
   git push origin main
   ```
4. Your changes will be automatically deployed to GitHub Pages

## Troubleshooting

- **Changes not appearing on the live site?** Check the Actions tab in your GitHub repository to see if there are any deployment errors.
- **Custom domain not working?** Verify your DNS settings and ensure you've added the correct records.
- **Styling issues?** Make sure you're using the correct Tailwind CSS classes and check for any HTML syntax errors.

## License

Feel free to use this template for your own resume.
