import { Client, GatewayIntentBits, Collection, Interaction } from 'discord.js';
import dotenv from 'dotenv';
import { loadCommands } from './utils/loader.js';
import { loadEvents } from './utils/eventLoader.js';

dotenv.config();

export class MyBot extends Client {
  commands: Collection<string, any> = new Collection();

  constructor() {
    super({
      intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent,
        GatewayIntentBits.GuildMembers,
        GatewayIntentBits.GuildModeration,
      ],
    });
  }

  async start() {
    await loadCommands(this);
    await loadEvents(this);

    this.on('ready', () => {
      console.log(`Logged in as ${this.user?.tag}!`);
    });

    this.on('interactionCreate', async (interaction: Interaction) => {
      if (!interaction.isChatInputCommand()) return;

      const command = this.commands.get(interaction.commandName);

      if (!command) return;

      try {
        await command.execute(interaction);
      } catch (error) {
        console.error(error);
        if (interaction.replied || interaction.deferred) {
          await interaction.followUp({ content: 'Error executing command!', ephemeral: true });
        } else {
          await interaction.reply({ content: 'Error executing command!', ephemeral: true });
        }
      }
    });

    await this.login(process.env.DISCORD_TOKEN);
  }
}

const bot = new MyBot();
bot.start();
