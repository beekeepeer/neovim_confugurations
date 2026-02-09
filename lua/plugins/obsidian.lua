return {
  "obsidian-nvim/obsidian.nvim",
  -- This part registers the group name in WhichKey
  init = function()
    require("which-key").add({
      { "<leader>o", group = "Obsidian", icon = "󱓧 " },
    })
  end,
  version = "*", 
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, 
    workspaces = {
      {
        name = "ObsidianVault",
        path = "~/Documents/ObsidianVault/",
      },
    },
    templates = {
      subdir = "Templates", 
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },


    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      if title ~= nil then
        -- Simply return the title exactly as you typed it in the [[link]]
        return title
      else
        return tostring(os.time())
      end
    end,


    ---@param note obsidian.Note
frontmatter = {
  ---@param note obsidian.Note
  func = function(note)
    -- 1. Start with EVERYTHING already in the note's frontmatter
    local out = {}
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end

    -- 2. Add or overwrite your specific fields
    -- This keeps existing aliases/tags if they exist, 
    -- or creates them from the note object if they are new.
    out.aliases = note.aliases
    out.tags = note.tags
    
    -- 3. Set your custom fields
    out.date = os.date("%Y-%m-%d")
    out.source = "my"

    return out
  end,
},  },
  keys = {
    -- Top Level / Navigation
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search Notes" },
    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Show Backlinks" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Search Tags" },
    { "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Switch Workspace" },

    -- Daily Notes
    { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Daily Notes List" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday's Note" },
    { "<leader>oj", "<cmd>Obsidian today<cr>", desc = "Today's Note" },
    { "<leader>ok", "<cmd>Obsidian tomorrow<cr>", desc = "Tomorrow's Note" },

    -- Note Actions
    { "<leader>of", "<cmd>Obsidian follow_link<cr>", desc = "Follow Link" },
    { "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle Checkbox" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "List All Links" },
    { "<leader>oi", "<cmd>Obsidian paste_img<cr>", desc = "Paste Image" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename Note" },
    { "<leader>oT", "<cmd>Obsidian toc<cr>", desc = "Table of Contents" },

    -- Templates & Help
    { "<leader>om", "<cmd>Obsidian template<cr>", desc = "Insert Template" },
    { "<leader>oN", "<cmd>Obsidian new_from_template<cr>", desc = "New Note from Template" },
    { "<leader>oh", "<cmd>Obsidian help<cr>", desc = "Obsidian Help" },
    { "<leader>og", "<cmd>Obsidian helpgrep<cr>", desc = "Grep Help" },

    -- Integration
    { "<leader>op", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian App" },

    -- Visual Mode Commands
    { "<leader>on", ":Obsidian extract_note<cr>", mode = "v", desc = "Extract to New Note" },
    { "<leader>ol", ":Obsidian link<cr>", mode = "v", desc = "Link Selection" },
    { "<leader>oL", ":Obsidian link_new<cr>", mode = "v", desc = "Link to New Note" },
  },
}
