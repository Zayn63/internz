// path: config/server.ts
import type { ServerConfig } from '@strapi/strapi';
import dotenv from 'dotenv';

// Load .env before anything else
dotenv.config();

const serverConfig: ServerConfig = ({ env }) => ({
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', 1337),
  app: {
    // Reads APP_KEYS from .env and splits on commas
    keys: env.array('APP_KEYS', [
      '4ca2a2badb00faacd1bfc87b3a9572325f7f70a90267ce90a0b7b9319d14516d',
      '895595019e3de2527424ebda23eaf71cc20522c478204849b2944aafc8e33391',
    ]),
  },
});

export default serverConfig;