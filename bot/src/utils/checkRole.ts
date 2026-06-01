import { GuildMember, PermissionResolvable } from 'discord.js';

/**
 * Checks if a member has a specific role or permission.
 * This is used for both bot commands and can be a reference for dashboard logic.
 */
export function hasPermission(member: GuildMember, permission: PermissionResolvable): boolean {
  return member.permissions.has(permission);
}

export function hasRole(member: GuildMember, roleId: string): boolean {
  return member.roles.cache.has(roleId);
}
