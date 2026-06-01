# Modern Discord Bot & Dashboard Monorepo

This project is a high-end, modern Discord bot with a matching web dashboard, designed to surpass existing solutions in both feature set and aesthetics.

## Features

- **Modern Discord Bot**: Built with `discord.js` and TypeScript.
  - Core Commands: `ping`, `setup`.
  - Moderation: `kick`, `ban`.
  - Advanced: Anti-Nuke, AI Integration (DB-ready).
- **Luxury Dashboard**: Built with Next.js 15, Tailwind CSS, and `lucide-react` icons.
  - Discord OAuth2 Integration.
  - Server Management Interface.
  - **Secure Admin Panel**: A specialized area that verifies administrative permissions before granting access.
- **Shared Database**: Prisma 7 (SQLite) to sync configurations between the bot and the web.

## Tech Stack

- **Language**: TypeScript (Bot & Web)
- **Bot**: Discord.js v14+
- **Frontend**: Next.js 15, Tailwind CSS
- **Authentication**: Next-Auth
- **Database**: Prisma 7 (SQLite)

## Getting Started

### Prerequisites

- Node.js 18+
- A Discord Developer Application (Bot Token, Client ID, Client Secret)

### Setup

1. **Clone the repository**
2. **Install dependencies**:
   ```bash
   npm install
   ```
3. **Configure Environment Variables**:
   Create a `.env` file in the root with:
   ```env
   DISCORD_TOKEN=your_bot_token
   DISCORD_CLIENT_ID=your_client_id
   DISCORD_CLIENT_SECRET=your_client_secret
   NEXTAUTH_URL=http://localhost:3000
   NEXTAUTH_SECRET=a_random_secure_string
   ```
4. **Generate Database Client**:
   ```bash
   npx prisma generate
   ```
5. **Run the projects**:
   - Bot: `npm run bot:dev`
   - Dashboard: `npm run dashboard:dev`

## Deployment

This project is ready for deployment on VPS or platforms like Vercel (dashboard) and PM2 (bot).

### Admin Security

The admin dashboard in `/admin` specifically checks for the `ADMINISTRATOR` permission on Discord. Unauthorized users are automatically redirected to the home page, ensuring maximum security for server owners.
