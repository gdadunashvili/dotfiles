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
  use('jceb/vim-orgmode')
  use( 'f-person/auto-dark-mode.nvim' ) -- autoamtic mode switching
  -- choose colorscemes here: https://vimcolorschemes.com/
  use( 'doums/darcula', {branch='release', run=':PlugInstall'}) -- Dark Theme
  use('sainnhe/edge', {as = 'edge'}) -- Light Theme
  use( 'ThePrimeagen/vim-be-good', {run=':PlugInstall'})
  use( 'chentoast/marks.nvim', {run=':PlugInstall'})
  use( 'JuliaEditorSupport/julia-vim', {run=':PlugInstall'})
  use( 'kdheepak/JuliaFormatter.vim', {run=':PlugInstall'})
  use( 'airblade/vim-gitgutter', {run=':PlugInstall'})
  use( 'czheo/mojo.vim', {run=':PlugInstall'})
  use( 'vim-airline/vim-airline', {run=':PlugInstall'})
  use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
  use( {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  })
  use( 'yorik1984/cobol.nvim')
  use( 'vim-scripts/TComment')
  use( 'rhysd/vim-grammarous')
  use( 'mbbill/undotree' )
  use( { "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"} }
    )
  use( 'theHamsta/nvim-dap-virtual-text' )
  use({
          "kdheepak/lazygit.nvim",
          -- optional for floating window border decoration
          requires = {
          "nvim-lua/plenary.nvim",
          },
          })
  use({
        "dnlhc/glance.nvim",
        -- config = function()
        -- require('glance').setup({
        --         -- your configuration
        --         })
        -- end,
        })
  -- use{ 'NeogitOrg/neogit',
  --   requires = {
  --       {'nvim-lua/plenary.nvim'},
  --       {'sindrets/diffview.nvim'},
  --       {'ibhagwan/fzf-lua'},
  --   },
  -- }
  --
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
