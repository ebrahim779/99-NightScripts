"use client";

import { useSession } from "next-auth/react";
import { useEffect, useState } from "react";
import axios from "axios";
import { Server } from "lucide-react";

export default function ServersPage() {
  const { data: session } = useSession();
  const [guilds, setGuilds] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (session?.accessToken) {
      axios.get("https://discord.com/api/users/@me/guilds", {
        headers: { Authorization: `Bearer ${session.accessToken}` }
      }).then(res => {
        // Filter for guilds where user has MANAGE_GUILD (0x20)
        const manageGuilds = res.data.filter((g: any) => (parseInt(g.permissions) & 0x20) === 0x20);
        setGuilds(manageGuilds);
        setLoading(false);
      }).catch(err => {
        console.error(err);
        setLoading(false);
      });
    }
  }, [session]);

  if (!session) return <div className="text-center mt-20 text-xl">Please login to see your servers.</div>;
  if (loading) return <div className="text-center mt-20 text-xl">Loading servers...</div>;

  return (
    <div>
      <h1 className="text-3xl font-bold mb-8">Select a Server</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {guilds.map(guild => (
          <div key={guild.id} className="bg-gray-800 p-6 rounded-xl border border-gray-700 hover:border-indigo-500 transition cursor-pointer group">
            <div className="flex items-center space-x-4">
              {guild.icon ? (
                <img src={`https://cdn.discordapp.com/icons/${guild.id}/${guild.icon}.png`} alt={guild.name} className="w-16 h-16 rounded-full" />
              ) : (
                <div className="w-16 h-16 rounded-full bg-indigo-600 flex items-center justify-center text-2xl font-bold">
                  {guild.name.charAt(0)}
                </div>
              )}
              <div>
                <h3 className="text-xl font-bold group-hover:text-indigo-400">{guild.name}</h3>
                <p className="text-gray-400 text-sm">Manage Settings</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
