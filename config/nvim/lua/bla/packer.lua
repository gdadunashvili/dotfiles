--  This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  })
  -- use('cdelledonne/vim-cmake')
  use('lervag/vimtex')
  use('jpalardy/vim-slime')
  use( 'f-person/auto-dark-mode.nvim' ) -- autoamtic mode switching
  -- choose colorscemes here: https://vimcolorschemes.com/
  use( 'doums/darcula', {branch='release', run=':PlugInstall'}) -- Dark Theme
  use('sainnhe/edge', {as = 'edge'}) -- Light Theme
  use( 'ThePrimeagen/vim-be-good', {run=':PlugInstall'})
  use( 'chentoast/marks.nvim', {run=':PlugInstall'})
  use( 'JuliaEditorSupport/julia-vim', {run=':PlugInstall'})
  use( 'kdheepak/JuliaFormatter.vim', {run=':PlugInstall'})
  use( 'czheo/mojo.vim', {run=':PlugInstall'})
  use( 'vim-airline/vim-airline', {run=':PlugInstall'})
  use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use( 'nvim-treesitter/nvim-treesitter-context' )
  use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
  use( {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  })
  use( 'vim-scripts/TComment')
  use( 'rhysd/vim-grammarous')
  use( 'mbbill/undotree' )
  use({"jay-babu/mason-nvim-dap.nvim",
    requires = {
      {"williamboman/mason.nvim"},
      {"mfussenegger/nvim-dap"}
    }
  })
  use( { "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio" }
              }
    )
  use( 'theHamsta/nvim-dap-virtual-text' )
  use({
        "dnlhc/glance.nvim",
        -- config = function()
        -- require('glance').setup({
        --         -- your configuration
        --         })
        -- end,
        })

  use( 'ryanoasis/vim-devicons' )
  use( {"neovim/nvim-lspconfig",
    requires = {
        {"williamboman/mason.nvim"},
        {"williamboman/mason-lspconfig.nvim"},
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/cmp-buffer"},
        {"hrsh7th/cmp-path"},
        {"hrsh7th/cmp-cmdline"},
        {"hrsh7th/nvim-cmp"},
        {"L3MON4D3/LuaSnip"},
        {"saadparwaiz1/cmp_luasnip"},
        {"j-hui/fidget.nvim"}
      }
    })
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
  use('27justin/virtuality.nvim')
  -- offline docs search
  use( 'sunaku/vim-dasht' )
  use('akinsho/toggleterm.nvim')
  -- git-integration
  use('airblade/vim-gitgutter', {run=':PlugInstall'})
  use('APZelos/blamer.nvim')
  use({
          "kdheepak/lazygit.nvim",
          -- optional for floating window border decoration
          requires = {
          "nvim-lua/plenary.nvim",
          },
          })

end)
