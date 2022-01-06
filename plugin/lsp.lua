local lspconfig = require 'lspconfig'
local trouble = require 'trouble'
-- local lsp_status = require 'lsp-status'
local lspkind = require 'lspkind'
local lsp = vim.lsp
local buf_keymap = vim.api.nvim_buf_set_keymap
local cmd = vim.cmd

vim.api.nvim_command 'hi link LightBulbFloatWin YellowFloat'
vim.api.nvim_command 'hi link LightBulbVirtualText YellowFloat'

local kind_symbols = {
  Text = '',
  Method = 'Ƒ',
  Function = 'ƒ',
  Constructor = '',
  Variable = '',
  Class = '',
  Interface = 'ﰮ',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '了',
  Keyword = '',
  Snippet = '﬌',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
}

local sign_define = vim.fn.sign_define
sign_define('LspDiagnosticsSignError', { text = '', numhl = 'RedSign' })
sign_define('LspDiagnosticsSignWarning', { text = '', numhl = 'YellowSign' })
sign_define('LspDiagnosticsSignInformation', { text = '', numhl = 'WhiteSign' })
sign_define('LspDiagnosticsSignHint', { text = '', numhl = 'BlueSign' })


require('lsp_signature').setup { bind = true, handler_opts = { border = 'single' }, floating_window = false}
local keymap_opts = { noremap = true, silent = true }
local function on_attach(client)
  require('lsp_signature').on_attach { bind = true, handler_opts = { border = 'single' } }
  buf_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gd', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gi', '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gS', '<cmd>lua vim.lsp.buf.signature_help()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gTD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keymap_opts)
  buf_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gr', '<cmd>lua require"telescope.builtin".lsp_references()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gA', '<cmd>lua require"telescope.builtin".lsp_code_actions()<CR>', keymap_opts)
  buf_keymap(0, 'n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', keymap_opts)
  buf_keymap(0, 'n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', keymap_opts)

  if client.resolved_capabilities.document_formatting then
    buf_keymap(0, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', keymap_opts)
  end

  cmd 'augroup lsp_aucmds'
  if client.resolved_capabilities.document_highlight == true then
    cmd 'au CursorHold <buffer> lua vim.lsp.buf.document_highlight()'
    cmd 'au CursorMoved <buffer> lua vim.lsp.buf.clear_references()'
  end

  cmd 'au CursorHold,CursorHoldI <buffer> lua require"nvim-lightbulb".update_lightbulb {sign = {enabled = false}, virtual_text = {enabled = true, text = ""}, float = {enabled = false, text = "", win_opts = {winblend = 100, anchor = "NE"}}}'
  cmd 'augroup END'
end

local servers = {
  bashls = {},
  clangd = {
    cmd = {
      'clangd', -- '--background-index',
      '--clang-tidy',
      '--completion-style=bundled',
      '--header-insertion=iwyu',
      '--cross-file-rename',
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  },
  cssls = {
    filetypes = { 'css', 'scss', 'less', 'sass' },
    root_dir = lspconfig.util.root_pattern('package.json', '.git'),
  },
  ghcide = {},
  html = {},
  jsonls = { cmd = { 'vscode-json-languageserver', '--stdio' } },
  julials = { settings = { julia = { format = { indent = 2 } } } },
  ocamllsp = {},
  pyright = { settings = { python = { formatting = { provider = 'yapf' } } } },
  rust_analyzer = {},
  -- sumneko_lua = function()
  --   return require('lua-dev').setup({lspconfig = {cmd = {'lua-language-server'}}})
  -- end,
  sumneko_lua = {
    --cmd = { 'lua-language-server' },
    cmd = { '/home/lzy/Code/github-downloads/lua-language-server/bin/Linux/lua-language-server' , "-E", "/home/lzy/Code/github-downloads/lua-language-server/main.lua"},
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
        runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
          },
        },
      },
    },
  },
  texlab = {
    settings = {
      texlab = {
        chktex = { onOpenAndSave = true },
        formatterLineLength = 100,
        forwardSearch = { executable = 'okular', args = { '--unique', 'file:%p#src:%l%f' } },
      },
    },
    commands = {
      TexlabForwardSearch = {
        function()
          local pos = vim.api.nvim_win_get_cursor(0)
          local params = {
            textDocument = { uri = vim.uri_from_bufnr(0) },
            position = { line = pos[1] - 1, character = pos[2] },
          }
          lsp.buf_request(0, 'textDocument/forwardSearch', params, function(err, _, _, _)
            if err then
              error(tostring(err))
            end
          end)
        end,
        description = 'Run synctex forward search',
      },
    },
  },
  tsserver = {},
  vimls = {},
  gopls = {},
  --denols = {
    --cmd = {"deno", "lsp"},
    --filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    --init_options = {
      --enable = true,
      --lint = false,
      --unstable = false
    --},
    --root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")
  --},
}

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.completion.completionItem.snippetSupport = true
client_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}
--client_capabilities = require('cmp_nvim_lsp').update_capabilities(client_capabilities)

for server, config in pairs(servers) do
  if type(config) == 'function' then
    config = config()
  end
  config.on_attach = on_attach
  config.capabilities = vim.tbl_deep_extend(
    'keep',
    config.capabilities or {},
    client_capabilities
  )
  lspconfig[server].setup(config)
end
