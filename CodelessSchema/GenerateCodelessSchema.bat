
::※下記のbatはデフォルトパスで設定しているため、別のフォルダにある場合は修正して下さい。
set vsdevcmd_path="C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"
set hython_path="C:\Program Files\Side Effects Software\Houdini 20.5.438\bin"

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
set PATH=%hython_path%
hython.exe hcmd.py
set error_code=%ERRORLEVEL%
del hcmd.py
::hythonでエラーだった際、ログを残して終了
IF %error_code% NEQ 0 (
	echo hython.exe Error occurred. Error code: %error_code% > error_log.txt
	echo hython.exe Error occurred. Error code: %error_code%
	pause
	exit
)


::cmakeによるビルド
echo Step 3: build CMake ...
mkdir build
cd build
call "vsdevcmd_path"

cmake ..
cmake --build .
cmake --install . --prefix ..

::releaseフォルダの構成
cd "%work_folder_path%\release\%schema_library_name%\resources
mkdir %schema_library_name%
cd %schema_library_name%
copy %work_folder_path%\"schema.usda" .\