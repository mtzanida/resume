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

GitHub automatically handles the deployment of your site to GitHub Pages through its built-in "pages build and deployment" workflow. Additionally, this repository includes a custom GitHub Actions workflow that generates a PDF version of your resume whenever you push changes to the main branch.

1. Push your changes to GitHub:
   ```bash
   git add .
   git commit -m "Update resume content"
   git push origin main
   ```

2. Go to your GitHub repository (https://github.com/mtzanida/resume)
3. Click on "Settings" > "Pages" in the left sidebar
4. Under "Source", select "GitHub Actions"
5. Two workflows will run automatically when you push to the main branch:
   - GitHub's built-in "pages build and deployment" workflow handles the site deployment
   - The custom "Resume PDF Generator" workflow generates and updates the PDF version of your resume
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

1. Add your profile image to the repository (e.g., `images/photo.png`)
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

#### Option 1: Upload a PDF File

1. Add your PDF resume to the repository (e.g., `assets/maria-tzanidaki-resume.pdf`)
2. Update the download button link:
   ```html
   <a href="assets/maria-tzanidaki-resume.pdf" class="inline-flex items-center px-4 py-2 border border-gray-700 rounded-md hover:bg-gray-800 bg-transparent text-white transition-colors" download>
     <i class="fas fa-download mr-2 w-4 h-4"></i>
     Download CV
   </a>
   ```

#### Option 2: Generate PDF from HTML using Pandoc

You can automatically generate a PDF version of your resume from the HTML file:

1. Install Pandoc (https://pandoc.org/installing.html) and weasyprint
   ```bash
   # On macOS
   brew install pandoc
   brew install weasyprint
   ```

2. Run the following command:
   ```bash
   pandoc index.html -o assets/maria-tzanidaki-resume.pdf --pdf-engine=weasyprint --css=pdf-styles.css
   ```

   Note: You may see warnings like `Ignored gap: min(4vw, 1.5em)` or `Ignored overflow-x: auto`, but these can be safely ignored as they don't affect the core formatting.

3. This will create a PDF that matches your website content
4. The included `pdf-styles.css` file contains styles optimized for PDF output

This approach ensures your PDF resume is always in sync with your website content.

#### Option 3: Automate PDF Generation and Deployment with GitHub Actions

This repository includes a GitHub Actions workflow that automatically generates the PDF and deploys your site to GitHub Pages whenever you push changes to the main branch:

1. The workflow file is located at `.github/workflows/resume-workflow.yml`:
   ```yaml
   name: Resume Website Workflow

   on:
     push:
       branches: [ "main" ]
     workflow_dispatch:  # Allows manual triggering

   permissions:
     contents: write  # Needed for updating PDF
     pages: write
     id-token: write

   jobs:
     build-and-deploy:
       environment:
         name: github-pages
         url: ${{ steps.deployment.outputs.page_url }}
       runs-on: ubuntu-latest
       steps:
         # Generate PDF resume
         - name: Checkout
           uses: actions/checkout@v3

         - name: Install PDF dependencies
           run: |
             sudo apt-get update
             sudo apt-get install -y pandoc weasyprint

         - name: Generate PDF
           run: |
             pandoc index.html -o assets/maria-tzanidaki-resume.pdf --pdf-engine=weasyprint --css=pdf-styles.css

         # Commit updated PDF if changed
         - name: Commit PDF if changed
           run: |
             git config --global user.name 'GitHub Actions'
             git config --global user.email 'actions@github.com'
             git add assets/maria-tzanidaki-resume.pdf
             git diff --quiet && git diff --staged --quiet || (git commit -m "Update PDF resume" && git push)

         # Deploy to GitHub Pages
         - name: Setup Pages
           uses: actions/configure-pages@v3

         - name: Upload artifact
           uses: actions/upload-pages-artifact@v2
           with:
             path: '.'

         - name: Deploy to GitHub Pages
           id: deployment
           uses: actions/deploy-pages@v2
   ```

2. This workflow will:
   - Run whenever you push changes to the main branch
   - Generate the PDF resume using Pandoc and weasyprint
   - Commit and push the updated PDF to your repository
   - Deploy your website to GitHub Pages

This ensures your PDF resume is always up-to-date with your website content and your site is automatically deployed.

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
