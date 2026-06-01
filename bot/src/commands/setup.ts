import { SlashCommandBuilder, ChatInputCommandInteraction, PermissionFlagsBits } from 'discord.js';

export const data = new SlashCommandBuilder()
  .setName('setup')
  .setDescription('Initial bot setup for the guild')
  .setDefaultMemberPermissions(PermissionFlagsBits.Administrator);

export async function execute(interaction: ChatInputCommandInteraction) {
  await interaction.reply({ content: 'Setting up the bot for this guild... (Integration with DB coming soon)', ephemeral: true });
}
