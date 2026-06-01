"use client";

import React from 'react';
import Link from 'next/link';
import { useSession, signIn, signOut } from "next-auth/react";
import { LayoutDashboard, Shield, LogOut, LogIn } from 'lucide-react';

export default function Layout({ children }: { children: React.ReactNode }) {
  const { data: session } = useSession();

  return (
    <div className="min-h-screen bg-gray-900 text-white font-sans">
      <nav className="bg-gray-800 border-b border-gray-700 px-6 py-4 flex justify-between items-center">
        <div className="flex items-center space-x-4">
          <Link href="/" className="text-2xl font-bold text-indigo-500">
            BOT DASHBOARD
          </Link>
          <div className="hidden md:flex space-x-6 ml-10">
            <Link href="/servers" className="hover:text-indigo-400 transition flex items-center gap-2">
              <LayoutDashboard size={18} /> Servers
            </Link>
            <Link href="/admin" className="hover:text-indigo-400 transition flex items-center gap-2">
              <Shield size={18} /> Admin Only
            </Link>
          </div>
        </div>
        <div>
          {session ? (
            <div className="flex items-center space-x-4">
              <img src={session.user?.image || ''} alt="User" className="w-8 h-8 rounded-full border border-indigo-500" />
              <span className="font-medium">{session.user?.name}</span>
              <button onClick={() => signOut()} className="bg-red-600 hover:bg-red-700 px-4 py-2 rounded-lg flex items-center gap-2 transition">
                <LogOut size={18} /> Logout
              </button>
            </div>
          ) : (
            <button onClick={() => signIn('discord')} className="bg-indigo-600 hover:bg-indigo-700 px-6 py-2 rounded-lg flex items-center gap-2 transition">
              <LogIn size={18} /> Login with Discord
            </button>
          )}
        </div>
      </nav>
      <main className="container mx-auto px-6 py-10">
        {children}
      </main>
    </div>
  );
}
