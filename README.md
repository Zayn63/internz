🚀 Task ! Overview
Strapi Setup 

This task involved:

Cloning the official Strapi repository.

Running Strapi locally.

Exploring the project folder structure.

Starting the Admin Panel.

Creating a sample content type.

Pushing your setup to GitHub.

Recording a Loom video walkthrough.

✅ Prerequisites

Node.js (LTS, v20 recommended)

Git

Yarn or npm

A GitHub account

A browser (Chrome/Edge)

Steps:

1. Clone Strapi Core Repository
cd D:\Projects
git clone https://github.com/strapi/strapi Strapi-core
cd Strapi-core


👉 This repo is for exploration. Check packages/, examples/, and docs/.

2. Create a New Strapi App (for running locally)
cd D:\Projects
npx create-strapi@latest my-strapi-app --quickstart
cd my-strapi-app
yarn develop   # or: npm run develop


👉 By default, Strapi uses SQLite, so no extra DB setup is needed.

3. Start Admin Panel

Open http://localhost:1337/admin

Register an admin user (email + password)

4. Create a Sample Content Type

Go to Content-Types Builder → Create new collection type

Example: Project with fields:

title → Short text

description → Rich text

start_date → Date

cover_image → Media (single image)

Save & restart Strapi (it rebuilds automatically).

Go to Content Manager → add a sample entry.

5. Pushed Project to GitHub