import { GuildChannel, AuditLogEvent, Events } from 'discord.js';

export const name = Events.ChannelDelete;

export async function execute(channel: GuildChannel) {
  if (!channel.guild) return;

  const fetchedLogs = await channel.guild.fetchAuditLogs({
    limit: 1,
    type: AuditLogEvent.ChannelDelete,
  });

  const deletionLog = fetchedLogs.entries.first();
  if (!deletionLog) return;

  const { executor, target } = deletionLog;

  // Logic: If someone deletes a channel and isn't the owner or a trusted ID
  if (executor && executor.id !== channel.guild.ownerId) {
    // In a real bot, we would check the DB for trusted users
    console.log(`Anti-Nuke: ${executor.tag} deleted channel ${channel.name}. Potential nuke detected.`);

    // Example action: Remove their roles
    const member = await channel.guild.members.fetch(executor.id);
    if (member && member.manageable) {
        await member.roles.set([], 'Anti-Nuke: Mass channel deletion detected.');
    }
  }
}
