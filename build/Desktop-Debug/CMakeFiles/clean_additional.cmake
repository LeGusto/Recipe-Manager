# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appRecipe-Manager_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appRecipe-Manager_autogen.dir/ParseCache.txt"
  "appRecipe-Manager_autogen"
  )
endif()
