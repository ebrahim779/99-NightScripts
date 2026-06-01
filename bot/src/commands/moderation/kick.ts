import { SlashCommandBuilder, ChatInputCommandInteraction, PermissionFlagsBits } from 'discord.js';

export const data = new SlashCommandBuilder()
  .setName('kick')
  .setDescription('Kicks a member from the server')
  .addUserOption(option => option.setName('target').setDescription('The member to kick').setRequired(true))
  .addStringOption(option => option.setName('reason').setDescription('The reason for kicking'))
  .setDefaultMemberPermissions(PermissionFlagsBits.KickMembers);

export async function execute(interaction: ChatInputCommandInteraction) {
  const user = interaction.options.getUser('target');
  const reason = interaction.options.getString('reason') ?? 'No reason provided';

  if (!user) return;

  const member = await interaction.guild?.members.fetch(user.id);

  if (!member) {
    return interaction.reply({ content: 'That user is not in this server.', ephemeral: true });
  }

  if (!member.kickable) {
    return interaction.reply({ content: 'I cannot kick this member.', ephemeral: true });
  }

  await member.kick(reason);
  await interaction.reply({ content: `Successfully kicked ${user.tag} for: ${reason}` });
}
