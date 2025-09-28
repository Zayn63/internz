# Internship Guidelines

Welcome to the DevOps Internship Program at PearlThoughts!

---

## Assigned Tasks

- Tasks will be assigned during training meetings.
- Timely completion is crucial for your learning and contribution to the team.

---

## Daily Status Updates

- You **must raise a Pull Request (PR)** and submit a status update **at the end of each day**.
- Failure to submit a PR will be marked as **absent**.
- Make sure the PR is always from your branch to main. Never commit anything to main!
- Attach links of PR and loom video in the PR comment

---

## 📌 Responsibilities & Expectations

### ✅ Participate in Virtual Meetings

- Attend all scheduled team meetings to stay updated on projects and tasks.

### ✅ Complete Assigned Tasks

- Work on designated tasks/projects assigned by your supervisor.

### ✅ Communicate Regularly

- Maintain open communication with your team via **Email** or **Microsoft Teams**.

### ✅ Document Work Progress

- Keep track of your work and **document progress regularly**.

### ✅ Support Team Members

- Offer help to colleagues whenever possible to foster teamwork.

### ✅ Meet Deadlines

- Ensure all tasks are completed **on time** and to a satisfactory standard.

### ✅ Maintain Professionalism

- Uphold professionalism in **all communications** and **interactions**.

---

### Let's work together to build skills, contribute to the team, and grow professionally! 💫

🚀 Task 1 Overview – Strapi Setup




This task involved:



\- Cloning the official Strapi repository.

\- Running Strapi locally.

\- Exploring the project folder structure.

\- Starting the Admin Panel.

\- Creating a sample content type.

\- Pushing setup to GitHub.

\- Recording a Loom video walkthrough.



✅ Prerequisites

----------------

\- Node.js (LTS, v20 recommended)  

\- Git  

\- Yarn or npm  

\- A GitHub account  

\- A browser (Chrome/Edge)  



---



\### Steps



\#### 1. Clone Strapi Core Repository

```bash

cd D:\\Projects

git clone https://github.com/strapi/strapi Strapi-core

cd Strapi-core

👉 This repo is for exploration. Check packages/, examples/, and docs/.



2\. Create a New Strapi App (for running locally)

bash

Copy code

cd D:\\Projects

npx create-strapi@latest my-strapi-app --quickstart

cd my-strapi-app

yarn develop   # or: npm run develop

👉 By default, Strapi uses SQLite, so no extra DB setup is needed.



3\. Start Admin Panel

Open http://localhost:1337/admin



Register an admin user (email + password).



4\. Create a Sample Content Type

In the Content-Types Builder → Create new collection type

Example: Project with fields:



title → Short text



description → Rich text



start\_date → Date



cover\_image → Media (single image)



Save \& restart Strapi (it rebuilds automatically).

Then go to Content Manager → add a sample entry.



🚀 Task 2 \& 3 Overview – Dockerized Strapi + PostgreSQL + Nginx

This task involved:



Setting up a Dockerized environment for Strapi.



Using PostgreSQL as the database.



Running Strapi \& Postgres on a user-defined Docker network.



Adding Nginx as a reverse proxy.



Making Strapi accessible at http://localhost:8080/admin.



Docker Setup

1\. Environment Variables (.env)

env

Copy code

APP\_KEYS=xxxx,yyyy

HOST=0.0.0.0

PORT=1337



ADMIN\_JWT\_SECRET=someOtherRandomStringHere

API\_TOKEN\_SALT=yetAnotherRandomStringHere

TRANSFER\_TOKEN\_SALT=anotherRandomStringHere

ENCRYPTION\_KEY=superSecretEncryptionKeyHere

JWT\_SECRET=wWmNkkPoVUuszXF9O7xRsg==



\# Database

DATABASE\_CLIENT=postgres

DATABASE\_HOST=strapi-db

DATABASE\_PORT=5432

DATABASE\_NAME=strapi

DATABASE\_USERNAME=strapi

DATABASE\_PASSWORD=strapi

DATABASE\_SSL=false

2\. Database Configuration (config/database.ts)

ts

Copy code

export default ({ env }) => ({

&nbsp; connection: {

&nbsp;   client: 'postgres',

&nbsp;   connection: {

&nbsp;     host: env('DATABASE\_HOST', 'strapi-db'),

&nbsp;     port: env.int('DATABASE\_PORT', 5432),

&nbsp;     database: env('DATABASE\_NAME', 'strapi'),

&nbsp;     user: env('DATABASE\_USERNAME', 'strapi'),

&nbsp;     password: env('DATABASE\_PASSWORD', 'strapi'),

&nbsp;     ssl: env.bool('DATABASE\_SSL', false),

&nbsp;     schema: env('DATABASE\_SCHEMA', 'public'),

&nbsp;   },

&nbsp;   pool: { min: 2, max: 10 },

&nbsp;   acquireConnectionTimeout: env.int('DATABASE\_CONNECTION\_TIMEOUT', 60000),

&nbsp; },

});

3\. Docker Compose (docker-compose.yml)

yaml

Copy code

services:

&nbsp; strapi:

&nbsp;   build: .

&nbsp;   container\_name: strapi-app

&nbsp;   restart: always

&nbsp;   env\_file: .env

&nbsp;   ports:

&nbsp;     - "1337:1337"

&nbsp;   depends\_on:

&nbsp;     - db

&nbsp;   volumes:

&nbsp;     - ./config:/app/config

&nbsp;     - ./src:/app/src

&nbsp;     - ./package.json:/app/package.json

&nbsp;     - ./yarn.lock:/app/yarn.lock

&nbsp;     - ./.env:/app/.env

&nbsp;   networks:

&nbsp;     - strapi-net



&nbsp; db:

&nbsp;   image: postgres:15

&nbsp;   container\_name: strapi-db

&nbsp;   restart: always

&nbsp;   environment:

&nbsp;     POSTGRES\_USER: strapi

&nbsp;     POSTGRES\_PASSWORD: strapi

&nbsp;     POSTGRES\_DB: strapi

&nbsp;   ports:

&nbsp;     - "5432:5432"

&nbsp;   volumes:

&nbsp;     - postgres-data:/var/lib/postgresql/data

&nbsp;   networks:

&nbsp;     - strapi-net



&nbsp; nginx:

&nbsp;   image: nginx:latest

&nbsp;   container\_name: strapi-nginx

&nbsp;   restart: always

&nbsp;   ports:

&nbsp;     - "8080:80"

&nbsp;   volumes:

&nbsp;     - ./nginx.conf:/etc/nginx/nginx.conf:ro

&nbsp;   depends\_on:

&nbsp;     - strapi

&nbsp;   networks:

&nbsp;     - strapi-net



volumes:

&nbsp; postgres-data:



networks:

&nbsp; strapi-net:

&nbsp;   driver: bridge

4\. Nginx Config (nginx.conf)

nginx

Copy code

events {}



http {

&nbsp; server {

&nbsp;   listen 80;



&nbsp;   location / {

&nbsp;     proxy\_pass http://strapi:1337;

&nbsp;     proxy\_set\_header Host $host;

&nbsp;     proxy\_set\_header X-Real-IP $remote\_addr;

&nbsp;     proxy\_set\_header X-Forwarded-For $proxy\_add\_x\_forwarded\_for;

&nbsp;     proxy\_set\_header X-Forwarded-Proto $scheme;

&nbsp;   }

&nbsp; }

}

Running the Setup

bash

Copy code

docker-compose up --build

Strapi available at → http://localhost:8080/admin



PostgreSQL running internally on → strapi-db:5432



Admin panel works with persistent DB.





