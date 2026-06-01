import NextAuth from "next-auth"
import DiscordProvider from "next-auth/providers/discord"

export const authOptions = {
  providers: [
    DiscordProvider({
      clientId: process.env.DISCORD_CLIENT_ID!,
      clientSecret: process.env.DISCORD_CLIENT_SECRET!,
      authorization: { params: { scope: 'identify guilds' } },
    }),
  ],
  callbacks: {
    async session({ session, token }: any) {
      session.accessToken = token.accessToken
      session.user.id = token.id
      return session
    },
    async jwt({ token, account, profile }: any) {
      if (account) {
        token.accessToken = account.access_token
        token.id = profile.id
      }
      return token
    },
  },
}

const handler = NextAuth(authOptions)
export { handler as GET, handler as POST }
