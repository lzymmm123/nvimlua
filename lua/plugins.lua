local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end


vim.cmd [[packadd packer.nvim]]

-- vim._update_package_paths()
--
--


local packer = nil
local function init()
  if packer == nil then
    packer =  require 'packer'
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()

   -- apperance
   use {"lukas-reineke/indent-blankline.nvim", config = [[require("config.apperance")]]}

   -- move
  use 'gcmt/wildfire.vim'
  use 'tpope/vim-surround'
  use 'scrooloose/nerdcommenter'
  use 'rhysd/accelerated-jk'
  use 'junegunn/vim-easy-align'

   -- Search
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
      },
      wants = {
        'popup.nvim',
        'plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
      },
      setup = [[require('config.telescope_setup')]],
      config = [[require('config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = 'tami5/sql.nvim',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
  }

  -- lsp
  use {
    'onsails/lspkind-nvim',
    'neovim/nvim-lspconfig',
    'folke/trouble.nvim',
    'ray-x/lsp_signature.nvim',
    'kosayoda/nvim-lightbulb',
  }

  --cmp
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'L3MON4D3/LuaSnip',config = [[require('config.snips')]]},
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    },
    config = [[require('config.cmp')]],
    event = 'InsertEnter *',
  }


  use {
    'windwp/nvim-autopairs',
    requires = 'hrsh7th/nvim-cmp',
    config = [[require('config.autopair')]],
    after = 'nvim-cmp'
  }

    -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
    config = [[require('config.treesitter')]]
  }

  use 'shaunsingh/nord.nvim'

  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require('config.bufferline')]],
    -- event = 'User ActuallyEditing',
    opt = false,
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require('config.nvim_tree')]],
  }

  -- tasks
  use {
    'GustavoKatel/telescope-asynctasks.nvim',
    requires = {'skywind3000/asynctasks.vim', 'skywind3000/asyncrun.vim'}
  }

  -- term
  use {
    "akinsho/toggleterm.nvim",
    config = [[require('config.term')]]
  }

end

local plugins = setmetatable({}, {
  __index = function(_,key)
    init()
    return packer[key]
  end,
})

return plugins
