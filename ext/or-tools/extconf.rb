require "mkmf-rice"

abort "Missing stdc++" unless have_library("stdc++")

$CXXFLAGS << " -std=c++11 -DUSE_CBC"

# or-tools warnings
$CXXFLAGS << " -Wno-sign-compare -Wno-shorten-64-to-32 -Wno-ignored-qualifiers"

inc, lib = dir_config("or-tools")
p Dir.pwd
p inc
p lib
puts "/app"
pp Dir["/app/**/*"]
puts "/tmp"
pp Dir["/tmp/**/*"]

inc ||= "/usr/local/include"
lib ||= "/usr/local/lib"

p ENV["BUILD_DIR"]
pp ENV

$INCFLAGS << " -I#{inc}"

$LDFLAGS << " -Wl,-rpath,#{lib}"
$LDFLAGS << " -L#{lib}"
abort "OR-Tools not found" unless have_library("ortools")

Dir["#{lib}/libabsl_*.a"].each do |lib|
  $LDFLAGS << " #{lib}"
end

create_makefile("or_tools/ext")
