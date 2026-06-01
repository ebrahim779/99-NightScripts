"use client";

import Link from "next/link";
import { ArrowLeft, Home } from "lucide-react";

export default function NotFound() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[70vh] text-center px-6">
      <div className="text-9xl font-black text-gray-800 mb-4 animate-pulse">404</div>
      <h1 className="text-4xl font-bold mb-4 text-white">Lost in the Void?</h1>
      <p className="text-gray-400 max-w-md mb-10 text-lg">
        The page you're looking for has vanished or never existed in this dimension.
      </p>

      <div className="flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4">
        <Link
          href="/"
          className="flex items-center justify-center gap-2 bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3 rounded-xl font-bold transition shadow-lg shadow-indigo-500/20"
        >
          <Home size={20} /> Return Home
        </Link>
        <button
          onClick={() => window.history.back()}
          className="flex items-center justify-center gap-2 bg-gray-800 hover:bg-gray-700 text-white px-8 py-3 rounded-xl font-bold transition border border-gray-700"
        >
          <ArrowLeft size={20} /> Go Back
        </button>
      </div>
    </div>
  );
}
