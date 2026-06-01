"use client";

import { useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import axios from "axios";
import { ShieldCheck, ShieldAlert, Loader2 } from "lucide-react";

// In a real application, this would be an environment variable or fetched from a DB
const ADMIN_ROLE_NAME = "Bot Admin";
const TARGET_GUILD_ID = process.env.NEXT_PUBLIC_ADMIN_GUILD_ID;

export default function AdminPage() {
  const { data: session, status } = useSession();
  const router = useRouter();
  const [isAuthorized, setIsAuthorized] = useState<boolean | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (status === "unauthenticated") {
      router.push("/");
      return;
    }

    if (status === "authenticated" && session?.accessToken) {
      checkAuthorization();
    }
  }, [status, session, router]);

  const checkAuthorization = async () => {
    try {
      // 1. Get user's guilds
      const guildsRes = await axios.get("https://discord.com/api/users/@me/guilds", {
        headers: { Authorization: `Bearer ${session?.accessToken}` }
      });

      const guilds = guildsRes.data;

      // 2. Check if user is in the required guild and has administrator permission
      // For this demo, we check if user has Administrator permission (0x8) in ANY guild they manage
      // Or we can check for a specific guild if TARGET_GUILD_ID is provided

      const adminInAnyGuild = guilds.some((g: any) => (parseInt(g.permissions) & 0x8) === 0x8);

      if (adminInAnyGuild) {
        setIsAuthorized(true);
      } else {
        setIsAuthorized(false);
        // Kick out after a delay
        setTimeout(() => {
          router.push("/");
        }, 3000);
      }
    } catch (err) {
      console.error("Auth check failed", err);
      setIsAuthorized(false);
      router.push("/");
    } finally {
      setLoading(false);
    }
  };

  if (loading || status === "loading") {
    return (
      <div className="flex flex-col items-center justify-center mt-40">
        <Loader2 className="w-12 h-12 text-indigo-500 animate-spin mb-4" />
        <h2 className="text-2xl font-semibold">Verifying Administrative Privileges...</h2>
      </div>
    );
  }

  if (isAuthorized === false) {
    return (
      <div className="flex flex-col items-center justify-center mt-40 bg-red-900/20 p-10 rounded-2xl border border-red-500">
        <ShieldAlert className="w-20 h-20 text-red-500 mb-6" />
        <h2 className="text-3xl font-bold text-red-500 mb-2">Access Denied</h2>
        <p className="text-gray-300 text-center max-w-md">
          You do not have the required administrative role to access this area.
          You will be redirected to the home page shortly.
        </p>
      </div>
    );
  }

  return (
    <div className="animate-in fade-in duration-500">
      <div className="flex items-center space-x-4 mb-8">
        <ShieldCheck className="w-10 h-10 text-green-500" />
        <h1 className="text-4xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-green-400 to-blue-500">
          Super Admin Panel
        </h1>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div className="bg-gray-800 p-8 rounded-2xl border border-gray-700 shadow-xl">
          <h3 className="text-xl font-bold mb-4">Global Statistics</h3>
          <div className="space-y-4">
            <div className="flex justify-between">
              <span className="text-gray-400">Total Guilds:</span>
              <span className="font-mono text-indigo-400">1,248</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-400">Total Users:</span>
              <span className="font-mono text-indigo-400">458,921</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-400">API Latency:</span>
              <span className="font-mono text-green-400">24ms</span>
            </div>
          </div>
        </div>

        <div className="bg-gray-800 p-8 rounded-2xl border border-gray-700 shadow-xl">
          <h3 className="text-xl font-bold mb-4">System Health</h3>
          <div className="w-full bg-gray-700 rounded-full h-4 mb-6">
            <div className="bg-green-500 h-4 rounded-full w-[98%]"></div>
          </div>
          <p className="text-sm text-gray-400 italic">All systems operational. No issues detected in the last 24 hours.</p>
        </div>

        <div className="bg-indigo-600/20 p-8 rounded-2xl border border-indigo-500 shadow-xl">
          <h3 className="text-xl font-bold mb-4">Broadcast Message</h3>
          <textarea
            className="w-full bg-gray-900 border border-gray-700 rounded-lg p-3 text-sm mb-4 focus:ring-2 focus:ring-indigo-500 outline-none"
            placeholder="Send a global notification to all guilds..."
            rows={3}
          ></textarea>
          <button className="w-full bg-indigo-600 hover:bg-indigo-700 py-2 rounded-lg font-bold transition">
            Send Broadcast
          </button>
        </div>
      </div>
    </div>
  );
}
