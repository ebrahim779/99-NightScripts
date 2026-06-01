import { SlashCommandBuilder, ChatInputCommandInteraction, PermissionFlagsBits } from 'discord.js';

export const data = new SlashCommandBuilder()
  .setName('ban')
  .setDescription('Bans a member from the server')
  .addUserOption(option => option.setName('target').setDescription('The member to ban').setRequired(true))
  .addStringOption(option => option.setName('reason').setDescription('The reason for banning'))
  .setDefaultMemberPermissions(PermissionFlagsBits.BanMembers);

export async function execute(interaction: ChatInputCommandInteraction) {
  const user = interaction.options.getUser('target');
  const reason = interaction.options.getString('reason') ?? 'No reason provided';

  if (!user) return;

  const member = await interaction.guild?.members.fetch(user.id);

  if (!member) {
      // Allow banning even if they are not in the guild (hack-ban)
      await interaction.guild?.members.ban(user.id, { reason });
      return interaction.reply({ content: `Successfully banned ${user.tag} (outside server) for: ${reason}` });
  }

  if (!member.bannable) {
    return interaction.reply({ content: 'I cannot ban this member.', ephemeral: true });
  }

  await member.ban({ reason });
  await interaction.reply({ content: `Successfully banned ${user.tag} for: ${reason}` });
}
