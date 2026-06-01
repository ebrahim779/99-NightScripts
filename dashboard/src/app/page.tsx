export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[60vh] text-center">
      <h1 className="text-6xl font-extrabold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 to-purple-600">
        The Ultimate Discord Solution
      </h1>
      <p className="text-xl text-gray-400 max-w-2xl mb-10">
        Experience the next generation of server management. Smart AI, advanced moderation,
        and a luxury dashboard designed for the world's most elite communities.
      </p>
      <div className="flex space-x-4">
        <button className="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3 rounded-full font-bold text-lg transition shadow-lg shadow-indigo-500/20">
          Get Started
        </button>
        <button className="bg-gray-800 hover:bg-gray-700 text-white px-8 py-3 rounded-full font-bold text-lg transition border border-gray-700">
          Learn More
        </button>
      </div>

      <div className="mt-20 grid grid-cols-1 md:grid-cols-3 gap-8 w-full max-w-5xl">
        <div className="bg-gray-800/50 p-8 rounded-3xl border border-gray-700 hover:border-indigo-500/50 transition">
          <div className="text-3xl mb-4">🛡️</div>
          <h3 className="text-xl font-bold mb-2">Anti-Nuke</h3>
          <p className="text-gray-400 text-sm">Advanced protection systems that keep your server safe from malicious actors automatically.</p>
        </div>
        <div className="bg-gray-800/50 p-8 rounded-3xl border border-gray-700 hover:border-indigo-500/50 transition">
          <div className="text-3xl mb-4">🤖</div>
          <h3 className="text-xl font-bold mb-2">Smart AI</h3>
          <p className="text-gray-400 text-sm">Context-aware AI that understands your community and provides helpful, natural responses.</p>
        </div>
        <div className="bg-gray-800/50 p-8 rounded-3xl border border-gray-700 hover:border-indigo-500/50 transition">
          <div className="text-3xl mb-4">⚡</div>
          <h3 className="text-xl font-bold mb-2">Fast & Secure</h3>
          <p className="text-gray-400 text-sm">Lightning-fast response times and a secure admin panel accessible only to those you trust.</p>
        </div>
      </div>
    </div>
  );
}
