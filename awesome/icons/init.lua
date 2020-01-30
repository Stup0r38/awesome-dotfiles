--      ██╗ ██████╗ ██████╗ ███╗   ██╗███████╗
--      ██║██╔════╝██╔═══██╗████╗  ██║██╔════╝
--      ██║██║     ██║   ██║██╔██╗ ██║███████╗
--      ██║██║     ██║   ██║██║╚██╗██║╚════██║
--      ██║╚██████╗╚██████╔╝██║ ╚████║███████║
--      ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


-- define icon folder directory
local dir = os.getenv('HOME') .. '/.config/awesome/icons/'

-- return icons
return {
  logout = dir .. 'logout.svg',
  sleep = dir .. 'sleep.svg',
  power = dir .. 'power.svg',
  lock = dir .. 'lock.svg',
  brightness = dir .. 'brightness.png',
  volume = dir .. 'volume.png',
  close = dir .. 'close.svg',
  open = dir .. 'open.svg',
  restart = dir .. 'restart.svg'
}
