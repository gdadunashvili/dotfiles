--  This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use ('lervag/vimtex')
  use( 'doums/darcula', {run=':PlugInstall'})
  use( 'preservim/nerdtree', {run=':PlugInstall'})
  use( 'ThePrimeagen/vim-be-good', {run=':PlugInstall'})
  use('sainnhe/edge', {as = 'edge'})
  use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use( 'ThePrimeagen/harpoon')
  use( 'vim-scripts/TComment')
  use( 'mbbill/undotree' )
  use( 'tpope/vim-fugitive' )
  use( 'f-person/auto-dark-mode.nvim' )
  use( 'ryanoasis/vim-devicons' )
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},     -- Required
		  {'hrsh7th/cmp-nvim-lsp'}, -- Required
		  {'L3MON4D3/LuaSnip'},     -- Required
	  }
  }
end)
