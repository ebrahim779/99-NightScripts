import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { MyBot } from '../index.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export async function loadCommands(client: MyBot) {
  const commandsPath = path.join(__dirname, '../commands');
  const items = fs.readdirSync(commandsPath);

  for (const item of items) {
    const itemPath = path.join(commandsPath, item);

    if (fs.lstatSync(itemPath).isDirectory()) {
        const commandFiles = fs.readdirSync(itemPath).filter(file => file.endsWith('.ts') || file.endsWith('.js'));
        for (const file of commandFiles) {
            const filePath = path.join(itemPath, file);
            const command = await import(`file://${filePath}`);
            if (command.data && command.execute) {
                client.commands.set(command.data.name, command);
            }
        }
    } else if (item.endsWith('.ts') || item.endsWith('.js')) {
        const command = await import(`file://${itemPath}`);
        if (command.data && command.execute) {
            client.commands.set(command.data.name, command);
        }
    }
  }
}
