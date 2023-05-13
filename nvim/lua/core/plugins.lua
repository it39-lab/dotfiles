local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'shaunsingh/nord.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
  use "lukas-reineke/indent-blankline.nvim"
  
  use {'romgrk/barbar.nvim', requires = {
  'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
  'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
}}
  -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths

  -- commenting with gc
  use("numToStr/Comment.nvim")

  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
}
  use {
    'nvim-treesitter/nvim-treesitter',
      run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
}
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
  requires = { {'nvim-lua/plenary.nvim'} }
}
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  if packer_bootstrap then
    require('packer').sync()
  end
end)
