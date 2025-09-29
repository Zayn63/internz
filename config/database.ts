import { StrapiDatabaseConfig } from '@strapi/strapi';

const database: StrapiDatabaseConfig = ({ env }) => ({
  connection: {
    client: 'postgres',
    connection: {
      host: env('DATABASE_HOST', 'your-rds-endpoint.rds.amazonaws.com'),
      port: env.int('DATABASE_PORT', 5432),
      database: env('DATABASE_NAME', 'strapidb'),
      user: env('DATABASE_USERNAME', 'strapi'),
      password: env('DATABASE_PASSWORD', 'yourpassword'),
      ssl: { rejectUnauthorized: false },
    },
    debug: false,
  },
});

export default database;
