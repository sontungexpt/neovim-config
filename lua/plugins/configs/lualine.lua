local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end
local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators
local component_separators = require("core.default-config").ui.lualine.options.component_separators

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
  colored = true,
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.blue },
    color_hint = { fg = colors.green }
  },
  always_visible = false,
  update_in_insert = true,
}

local branch = {
  "branch",
  icon = " ",
  color = { fg = colors.pink },
  padding = { left = 2, right = 1 },
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " },
}

local location = {
  "location",
  padding = 1,
}

local modes = {
  "mode",
  separator = section_separators,
}

local indent = function()
  return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp_progess = function()
  msg = msg or "✖"
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return "NO LSP"
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}
  local copilot_active = true

  local null_ls = require("null-ls")

  local alternative_methods = {
    null_ls.methods.DIAGNOSTICS,
    null_ls.methods.DIAGNOSTICS_ON_OPEN,
    null_ls.methods.DIAGNOSTICS_ON_SAVE,
  }

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" and client.name ~= "copilot" then
      table.insert(buf_client_names, client.name)
    end

    if client.name == "copilot" then
      copilot_active = true
    end
  end

  local function list_registered_providers_names(filetype)
    local s = require("null-ls.sources")
    local available_sources = s.get_available(filetype)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end
    return registered
  end

  local function list_registered(filetype)
    local registered_providers = list_registered_providers_names(filetype)
    local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
      return registered_providers[m] or {}
    end, alternative_methods))
    return providers_for_methods
  end

  local function formatters_list_registered(filetype)
    local registered_providers = list_registered_providers_names(filetype)
    return registered_providers[null_ls.methods.FORMATTING] or {}
  end

  -- formatters
  local supported_formatters = formatters_list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_formatters)

  -- linters
  local supported_linters = list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_linters)
  local unique_client_names = vim.fn.uniq(buf_client_names)

  local language_servers = "" .. table.concat(unique_client_names, ", ") .. ""

  if copilot_active then
    language_servers = language_servers .. "%#SLCopilot#" .. "    "
    vim.cmd("hi SLCopilot guifg=colors.white")
    -- vim.cmd("hi SLCopilot guibg=#000000")
  end

  return language_servers
end

lualine.setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "tokyonight",
    component_separators = component_separators,
    section_separators = section_separators,
    disabled_filetypes = { "lazy", "floaterm", "NvimTree", "packer", "mason", "toggleterm" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      modes,
    },
    lualine_b = {
      {
        "filetype",
        icon_only = true,
        colored = true,
        padding = { left = 2 },
        color = { bg = "#272640" },
      },
      {
        "filename",
        padding = 1,
        separator = section_separators,
        color = { bg = "#272640", fg = colors.fg, gui = "bold" },
        file_status = true,
        newfile_status = false,
        path = 4,
        symbols = {
          modified = "●",
          readonly = " ",
          unnamed = "",
          newfile = " [New]",
        },
      },
    },
    lualine_c = {
      branch,
      {
        "diff",
      }
    },
    lualine_x = {
      diagnostics,
      {
        lsp_progess,
        color = { fg = colors.magenta },
      },
      {
        function()
          return "Indent"
        end,
        separator = section_separators,
        color = { bg = colors.blue, fg = colors.black },
      },
      indent,
      {
        'encoding',
        separator = section_separators,
        padding = 1,
        color = { bg = colors.yellow, fg = colors.black },
      },
      location,
      {
        function()
          return ""
        end,
        separator = section_separators,
        color = { bg = colors.orange, fg = colors.black },
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
})
