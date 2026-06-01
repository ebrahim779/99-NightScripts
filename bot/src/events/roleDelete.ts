import { Role, AuditLogEvent, Events } from 'discord.js';

export const name = Events.GuildRoleDelete;

export async function execute(role: Role) {
  if (!role.guild) return;

  const fetchedLogs = await role.guild.fetchAuditLogs({
    limit: 1,
    type: AuditLogEvent.RoleDelete,
  });

  const deletionLog = fetchedLogs.entries.first();
  if (!deletionLog) return;

  const { executor } = deletionLog;

  if (executor && executor.id !== role.guild.ownerId) {
    console.log(`Anti-Nuke: ${executor.tag} deleted role ${role.name}. Potential nuke detected.`);

    const member = await role.guild.members.fetch(executor.id);
    if (member && member.manageable) {
        await member.roles.set([], 'Anti-Nuke: Mass role deletion detected.');
    }
  }
}
