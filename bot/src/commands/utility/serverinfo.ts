import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';

export const data = new SlashCommandBuilder()
  .setName('serverinfo')
  .setDescription('Displays information about the server');

export async function execute(interaction: ChatInputCommandInteraction) {
  const { guild } = interaction;
  if (!guild) return;

  const embed = new EmbedBuilder()
    .setTitle(`💎 Server Information - ${guild.name}`)
    .setThumbnail(guild.iconURL())
    .setColor('#5865F2')
    .addFields(
      { name: '🆔 Server ID', value: guild.id, inline: true },
      { name: '👑 Owner', value: `<@${guild.ownerId}>`, inline: true },
      { name: '👥 Members', value: `${guild.memberCount}`, inline: true },
      { name: '📅 Created At', value: `<t:${Math.floor(guild.createdTimestamp / 1000)}:R>`, inline: true },
      { name: '🛡️ Verification Level', value: `${guild.verificationLevel}`, inline: true },
      { name: '🚀 Boosts', value: `${guild.premiumSubscriptionCount || 0}`, inline: true },
    )
    .setFooter({ text: 'Premium Bot Experience' })
    .setTimestamp();

  await interaction.reply({ embeds: [embed] });
}
