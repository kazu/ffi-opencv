require "rbconfig"

module CV
  extend FFI::Library
  case Config::CONFIG['target_os']
  when /linux/
    ffi_lib 'libcv.so.2.1'
  when /darwin/
    ffi_lib '/opt/local/lib/libcv.dylib' 
  end
end

module Highgui
  extend FFI::Library
  case Config::CONFIG['target_os']
  when /linux/
    ffi_lib 'libhighgui.so.2.1'
  when /darwin/
    ffi_lib '/opt/local/lib/libhighgui.dylib' 
  end
end
