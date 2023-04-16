require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tomasr/molokai'
  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '~/',
          syntax = 'markdown',
          ext = '.md',
        }
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown', 
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown'
      }
    end
  }
end)
