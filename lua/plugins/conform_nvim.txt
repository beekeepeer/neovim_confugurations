-- ~/.config/nvim/lua/plugins/disable-autosave-format.lua
-- Or Windows equivalent path

return {
  "stevearc/conform.nvim",
  -- You can also specify `event = 'VeryLazy'` or other triggers if needed,
  -- but targeting by name is usually sufficient for overrides.
  opts = {
    -- Disable format on save
    format_on_save = nil, -- Setting it to nil or false disables it

    -- IMPORTANT: If you have other conform.nvim options you customized elsewhere,
    -- you might need to merge them here or ensure this override doesn't
    -- remove them unintentionally. If this is your *only* conform override,
    -- this should be fine.

    -- Example: ensure formatters are still defined if needed
    -- formatters_by_ft = {
    --   lua = { "stylua" },
    --   python = { "isort", "black" },
    --   php = { "php-cs-fixer", "pint" }, -- Or whatever you use
    --   -- etc.
    -- },
  },
}
