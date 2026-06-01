import { SlashCommandBuilder, ChatInputCommandInteraction } from 'discord.js';

export const data = new SlashCommandBuilder()
  .setName('ask')
  .setDescription('Ask the premium AI assistant anything')
  .addStringOption(option => option.setName('question').setDescription('Your question').setRequired(true));

export async function execute(interaction: ChatInputCommandInteraction) {
  const question = interaction.options.getString('question');

  await interaction.deferReply();

  // Placeholder for AI API call (e.g. OpenAI, Anthropic)
  setTimeout(async () => {
    await interaction.editReply({
      content: `### 🤖 AI Assistant\n**Question:** ${question}\n\n**Answer:** This is a premium AI response. To enable full AI capabilities, please configure your API key in the dashboard.`
    });
  }, 1500);
}
