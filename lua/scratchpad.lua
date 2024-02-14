local module_root = function(--[[modname]]_)
  return '/Users/fernando/.dotfiles/config/nvim/lua/hello'
end

local scan_dir = function(path, callback)
  local handle = vim.loop.fs_scandir(path)
  while handle do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end
    callback(path .. '/' .. name, name, type)
  end
end

local scan_module = function(modname, callback)
  local root = module_root(modname)
  if not root then return end
  scan_dir(root, function(path, name, type)
    if name == 'init.lua' then
      callback(modname)
    elseif (type == 'file' or type == 'link') and name:sub(-4) == '.lua' then
      callback(modname .. '.' .. name:sub(1, -5))
    elseif type == 'directory' and vim.loop.fs_stat(path .. '/init.lua') then
      callback(modname .. '.' .. name)
    end
  end)
end

local merge_module = function(modname)
  local modules = {}
  scan_module(modname, function(name)
    table.insert(modules, require(name))
  end)
  return vim.tbl_extend('force', {}, unpack(modules))
end

P(merge_module('hello'))


