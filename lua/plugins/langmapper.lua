return {
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1, -- Важно загрузить раньше других плагинов
    config = function()
      local lm = require("langmapper")
      lm.setup({
        -- Автоматически маппим стандартные команды
        map_all_queues = true,
      })
      -- Инициализация
      lm.hack_get_keymap()
    end,
  },
}
