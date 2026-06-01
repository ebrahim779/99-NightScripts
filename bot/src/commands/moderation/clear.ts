import { SlashCommandBuilder, ChatInputCommandInteraction, PermissionFlagsBits, TextChannel } from 'discord.js';

export const data = new SlashCommandBuilder()
  .setName('clear')
  .setDescription('Deletes a specified amount of messages')
  .addIntegerOption(option => option.setName('amount').setDescription('Number of messages to delete (1-100)').setRequired(true))
  .setDefaultMemberPermissions(PermissionFlagsBits.ManageMessages);

export async function execute(interaction: ChatInputCommandInteraction) {
  const amount = interaction.options.getInteger('amount')!;

  if (amount < 1 || amount > 100) {
    return interaction.reply({ content: 'Please provide an amount between 1 and 100.', ephemeral: true });
  }

  const channel = interaction.channel as TextChannel;

  try {
    const deleted = await channel.bulkDelete(amount, true);
    await interaction.reply({ content: `Successfully deleted ${deleted.size} messages.`, ephemeral: true });
  } catch (error) {
    console.error(error);
    await interaction.reply({ content: 'There was an error trying to clear messages in this channel!', ephemeral: true });
  }
}
