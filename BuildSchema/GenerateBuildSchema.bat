@echo off

::※下記のbatはデフォルトパスで設定しているため、別のフォルダにある場合は修正して下さい。
set vsdevcmd_path="C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"

::入力箇所
set /p schema_library_name="Set SchemaLibraryName: "
set /p schema_library_prefix="Set SchemaLibraryPrefix: "
set /p open_usd_folder_path="Set OpenUSDFolderPath: "
set /p usd_build_folder_path="Set USDBuildFolderPath: "

::ビルドに必要なフォルダを用意

::前作業のファイルが残っていた場合削除
for %%f in (*.*) do (
    if not "%%f"=="schema.usda" if not "%%f"=="generateBuildSchema.bat" del /q "%%f"
)
if exist "release" rmdir /s /q "release"
if exist "build" rmdir /s /q "build"

:: CMakeListsの作成
echo Step 1: Make CMakeLists.txt ...
set work_folder_path=%CD%
set cmake_text="%work_folder_path%\CMakeLists.txt"
echo set(PXR_PACKAGE %schema_library_name%) > %cmake_text%
echo pxr_plugin(${PXR_PACKAGE} >> %cmake_text%
echo     INCLUDE_SCHEMA_FILES >> %cmake_text%
echo     LIBRARIES >> %cmake_text%
echo         tf >> %cmake_text%
echo         sdf >> %cmake_text%
echo         usd >> %cmake_text%
echo         vt >> %cmake_text%
echo     INCLUDE_DIRS >> %cmake_text%
echo         ${Boost_INCLUDE_DIRS} >> %cmake_text%
echo         ${PYTHON_INCLUDE_DIRS} >> %cmake_text%
echo     PUBLIC_HEADERS >> %cmake_text%
echo         api.h >> %cmake_text%
echo     PYTHON_CPPFILES >> %cmake_text%
echo         moduleDeps.cpp  >> %cmake_text%
echo     PYMODULE_FILES >> %cmake_text%
echo         __init__.py >> %cmake_text%
echo ) >> %cmake_text%

:: moduleDeps.cppの生成
echo Step 2: Make moduleDeps.cpp ...
set moduledeps_cpp="%work_folder_path%\moduleDeps.cpp"
echo #include "pxr/pxr.h" > %moduledeps_cpp%
echo #include "pxr/base/tf/registryManager.h" >> %moduledeps_cpp%
echo #include "pxr/base/tf/scriptModuleLoader.h" >> %moduledeps_cpp%
echo #include "pxr/base/tf/token.h" >> %moduledeps_cpp%
echo #include ^<vector^> >> %moduledeps_cpp%
echo. >> %moduledeps_cpp%
echo PXR_NAMESPACE_OPEN_SCOPE >> %moduledeps_cpp%
echo. >> %moduledeps_cpp%
echo TF_REGISTRY_FUNCTION(TfScriptModuleLoader) { >> %moduledeps_cpp%
echo     const std::vector^<TfToken^> reqs = { >> %moduledeps_cpp%
echo         TfToken("sdf"), >> %moduledeps_cpp%
echo         TfToken("tf"), >> %moduledeps_cpp%
echo         TfToken("usd"), >> %moduledeps_cpp%
echo         TfToken("vt") >> %moduledeps_cpp%
echo     }; >> %moduledeps_cpp%
echo     TfScriptModuleLoader::GetInstance(). >> %moduledeps_cpp%
echo         RegisterLibrary(TfToken("%schema_library_name%"), TfToken("pxr.%schema_library_prefix%"), reqs); >> %moduledeps_cpp%
echo } >> %moduledeps_cpp%
echo. >> %moduledeps_cpp%
echo PXR_NAMESPACE_CLOSE_SCOPE >> %moduledeps_cpp%

::既存のTutorialデータから不足データをコピー
echo Step 3: Copy module.cpp __init__.py pch.h ...
copy %open_usd_folder_path%\extras\usd\examples\usdSchemaExamples\module.cpp %work_folder_path%\
copy %open_usd_folder_path%\extras\usd\examples\usdSchemaExamples\__init__.py %work_folder_path%\
copy %open_usd_folder_path%\extras\usd\examples\usdSchemaExamples\pch.h %work_folder_path%\

::usdGenSchema処理
echo Step 4: Call usdGenSchema ...
set PATH=%PATH%%usd_build_folder_path%\bin;
set PATH=%PATH%%usd_build_folder_path%\lib;
set PATH=%PATH%%usd_build_folder_path%\plugin;
set PYTHONPATH=%usd_build_folder_path%\lib\python;

::usdGenSchema処理が終わると強制的にbatが終了してしまうため、python経由で処理を呼び出す
echo import subprocess > script.py
echo command = ["usdGenSchema", "schema.usda", "."] >> script.py
echo subprocess.run(command, shell=True, check=True) >> script.py

python script.py
del script.py

::ビルド対象としてCMakeListsに追加
cd %open_usd_folder_path%\extras\usd\examples
set cmakelists_txt=%cd%\CMakeLists.txt
copy %cmakelists_txt% %cmakelists_txt%.bak
echo. >> %cmakelists_txt%
echo add_subdirectory(%schema_library_name%) >> %cmakelists_txt%

::ビルドに必要なファイルを配置
mkdir %schema_library_name%
cd %schema_library_name%
xcopy %work_folder_path% .\ /H /Y


::CMakeBuild
echo Step 5: build_usd ...
call %vsdevcmd_path%
cd %open_usd_folder_path%\build_scripts
python build_usd.py "%usd_build_folder_path%"


::CMakeListsを元に戻す
copy /Y %cmakelists_txt%.bak %cmakelists_txt%
del %cmakelists_txt%.bak

::リリースフォルダにビルドデータを配置
cd %work_folder_path%
mkdir release
cd release
mkdir %schema_library_name%
cd %schema_library_name%

copy %usd_build_folder_path%\share\usd\examples\plugin\%schema_library_name%.dll .\
copy %usd_build_folder_path%\share\usd\examples\plugin\%schema_library_name%.lib .\
xcopy %usd_build_folder_path%\share\usd\examples\plugin\%schema_library_name% .\ /E /H /Y