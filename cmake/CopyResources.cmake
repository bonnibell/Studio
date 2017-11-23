# Sourced from https://stackoverflow.com/q/697560/996468
# Copy single files
macro(copy_files files)
foreach(file ${files})
    message(STATUS "Copying resource ${file}")
    file(COPY ${file} DESTINATION ${DestDir})
endforeach()
endmacro()

# Copy full directories
macro(copy_dirs dirs)
foreach(dir ${dirs})
    # Replace / at the end of the path (copy dir content VS copy dir)
    string(REGEX REPLACE "/+$" "" dirclean "${dir}")
    message(STATUS "Copying resource ${dirclean}")
    file(COPY ${dirclean} DESTINATION ${DestDir})
endforeach()
endmacro()

# Copy Jahshaka data folders after a successful build
set(DataDirs app assets scenes)
foreach(dir ${DataDirs})
	add_custom_command(
		TARGET Jahshaka POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy_directory
				${PROJECT_SOURCE_DIR}/${dir}
				${DestDir}/${dir})
endforeach()