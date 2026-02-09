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
      -- If a title is provided (e.g., [[People]]), use it as the filename
      if title ~= nil then
        -- Optional: Clean up the title to be file-system friendly
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- Fallback to a random ID if no title is provided
        return tostring(os.time()) .. "-" .. math.random(1000, 9999)
      end
    end,

    ---@param note obsidian.Note
    frontmatter = {
      ---@param note obsidian.Note
      func = function(note)
        -- 1. Initialize 'out' without the 'id' field
        local out = { 
          aliases = note.aliases, 
          tags = note.tags 
        }

        -- Separate Date and Time for better organization
        out.date = os.date("%Y-%m-%d")
        out.time = os.date("%H:%M")

        -- 3. (Optional) If the note has a title, include it
        if note.title then
          out.title = note.title
        end

        -- 4. Merge metadata from templates
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

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
