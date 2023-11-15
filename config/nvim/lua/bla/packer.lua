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
  use('cdelledonne/vim-cmake')
  use('lervag/vimtex')
  use('jpalardy/vim-slime')
  use( 'doums/darcula', {branch='release', run=':PlugInstall'})
  use( 'ThePrimeagen/vim-be-good', {run=':PlugInstall'})
  use( 'chentoast/marks.nvim', {run=':PlugInstall'})
  use( 'JuliaEditorSupport/julia-vim', {run=':PlugInstall'})
  use( 'kdheepak/JuliaFormatter.vim', {run=':PlugInstall'})
  use( 'airblade/vim-gitgutter', {run=':PlugInstall'})
  use( 'czheo/mojo.vim', {run=':PlugInstall'})
  use( 'vim-airline/vim-airline', {run=':PlugInstall'})
  use('sainnhe/edge', {as = 'edge'})
  use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use( 'ThePrimeagen/harpoon')
  use( 'yorik1984/cobol.nvim')
  use( 'vim-scripts/TComment')
  use( 'mbbill/undotree' )
  use({
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })
  -- use{ 'NeogitOrg/neogit',
  --   requires = {
  --       {'nvim-lua/plenary.nvim'},
  --       {'sindrets/diffview.nvim'},
  --       {'ibhagwan/fzf-lua'},
  --   },
  -- }
  --

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
