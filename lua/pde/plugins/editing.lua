return {
  {
    'jackMort/ChatGPT.nvim',
    cmd = { 'ChatGPT', 'ChatGPTActAs', 'ChatGPTEditWithInstructions' },
    config = function()
      require('chatgpt').setup({
        chat = {
          keymaps = {
            close = {
              '<C-c>',--[[ , '<Esc>' ]]
            },
          },
        },
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}
