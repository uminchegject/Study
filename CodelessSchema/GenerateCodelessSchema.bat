:: 入力箇所
set /p schema_library_name=" Set SchemaLibraryName: "


:: CMakeLists.txtの作成
echo Step 1: Make CMakeLists.txt ...
set work_folder_path=%CD%
set cmake_list="%work_folder_path%\CMakeLists.txt"
echo set(PROJECT_NAME %schema_library_name%) > %cmake_list%
echo project(${PROJECT_NAME}) >> %cmake_list%
echo set(PLUG_INFO_LIBRARY_PATH "") >> %cmake_list%
echo set(PLUG_INFO_RESOURCE_PATH "resources") >> %cmake_list%
echo set(PLUG_INFO_ROOT "..") >> %cmake_list%
echo configure_file(${PROJECT_SOURCE_DIR}/plugInfo.json >> %cmake_list%
echo                ${PROJECT_BINARY_DIR}/plugInfo.json >> %cmake_list%
echo                @ONLY) >> %cmake_list%
echo install(FILES >> %cmake_list%
echo             generatedSchema.usda >> %cmake_list%
echo             ${PROJECT_BINARY_DIR}/plugInfo.json >> %cmake_list%
echo         DESTINATION >> %cmake_list%
echo             ./release/${PROJECT_NAME}/resources >> %cmake_list%
echo ) >> %cmake_list%


::hcmdを通じてusdGenSchemaを呼び出す
echo Step 2: Call usdGenSchema ...
echo import subprocess > hcmd.py
echo command = ["usdGenSchema", "schema.usda", "."] >> hcmd.py
echo subprocess.run(command, shell=True, check=True) >> hcmd.py

::hython経由でusdGenSchemaを呼び出し
set PATH=C:\Program Files\Side Effects Software\Houdini 20.5.278\bin
hython.exe hcmd.py
del hcmd.py

pause
::cmakeによるビルド
echo Step 3: build CMake ...
mkdir build
cd build
call "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"



cmake ..
cmake --build .
cmake --install . --prefix ..

pause

::releaseフォルダの構成
cd "%work_folder_path%\release\%schema_library_name%\resources
mkdir %schema_library_name%
cd %schema_library_name%
copy %work_folder_path%\"schema.usda" .\