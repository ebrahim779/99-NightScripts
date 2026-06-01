import { GuildBan, AuditLogEvent, Events } from 'discord.js';

export const name = Events.GuildBanAdd;

// Track bans per user in memory (short term)
const banTracker = new Map<string, { count: number, lastBan: number }>();

export async function execute(ban: GuildBan) {
  const guild = ban.guild;

  const fetchedLogs = await guild.fetchAuditLogs({
    limit: 1,
    type: AuditLogEvent.MemberBanAdd,
  });

  const banLog = fetchedLogs.entries.first();
  if (!banLog) return;

  const { executor } = banLog;
  if (!executor || executor.id === guild.ownerId) return;

  const now = Date.now();
  const userData = banTracker.get(executor.id) || { count: 0, lastBan: 0 };

  // Reset if last ban was more than 1 minute ago
  if (now - userData.lastBan > 60000) {
    userData.count = 0;
  }

  userData.count++;
  userData.lastBan = now;
  banTracker.set(executor.id, userData);

  // Threshold: 5 bans in 1 minute
  if (userData.count >= 5) {
    console.log(`Anti-Nuke: ${executor.tag} is banning users rapidly. Mass ban detected.`);

    const member = await guild.members.fetch(executor.id);
    if (member && member.manageable) {
        await member.roles.set([], 'Anti-Nuke: Mass ban detected.');
        await guild.members.ban(executor.id, { reason: 'Anti-Nuke: Mass ban detected.' });
    }

    banTracker.delete(executor.id);
  }
}
