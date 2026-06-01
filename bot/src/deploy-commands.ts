import { REST, Routes } from 'discord.js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const commands = [];
const commandsPath = path.join(__dirname, '../commands');
const items = fs.readdirSync(commandsPath);

for (const item of items) {
  const itemPath = path.join(commandsPath, item);

  if (fs.lstatSync(itemPath).isDirectory()) {
      const commandFiles = fs.readdirSync(itemPath).filter(file => file.endsWith('.ts') || file.endsWith('.js'));
      for (const file of commandFiles) {
          const filePath = path.join(itemPath, file);
          const command = await import(`file://${filePath}`);
          if (command.data) {
              commands.push(command.data.toJSON());
          }
      }
  } else if (item.endsWith('.ts') || item.endsWith('.js')) {
      const command = await import(`file://${itemPath}`);
      if (command.data) {
          commands.push(command.data.toJSON());
      }
  }
}

const rest = new REST().setToken(process.env.DISCORD_TOKEN!);

(async () => {
	try {
		console.log(`Started refreshing ${commands.length} application (/) commands.`);

		const data: any = await rest.put(
			Routes.applicationCommands(process.env.DISCORD_CLIENT_ID!),
			{ body: commands },
		);

		console.log(`Successfully reloaded ${data.length} application (/) commands.`);
	} catch (error) {
		console.error(error);
	}
})();
