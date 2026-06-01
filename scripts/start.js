import { spawn } from 'child_process';

// Render provides a PORT environment variable.
// The bot doesn't need a port, but the dashboard does.
const port = process.env.PORT || 3000;

console.log('Starting Bot and Dashboard...');

const bot = spawn('npm', ['run', 'start', '-w', 'bot'], { stdio: 'inherit', shell: true });
const dashboard = spawn('npm', ['run', 'start', '-w', 'dashboard'], {
  stdio: 'inherit',
  shell: true,
  env: { ...process.env, PORT: port }
});

bot.on('exit', (code) => {
  console.log(`Bot process exited with code ${code}`);
  process.exit(code || 0);
});

dashboard.on('exit', (code) => {
  console.log(`Dashboard process exited with code ${code}`);
  process.exit(code || 0);
});
