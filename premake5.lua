tdir = "bin/%{cfg.buildcfg}/%{prj.name}/%{cfg.architecture}"
odir = "bin-obj/%{cfg.buildcfg}/%{prj.name}"
project "AngelScript"
        kind "StaticLib"
        language "C++"
        cppdialect "C++17"
        
        staticruntime "off"
        targetdir(tdir)
        objdir(odir)
        includedirs {
        "include",
        }
        files {
            "include/*.h",
            "include/*.hpp",
            "include/*.cpp",
            "source/*.h",
            "source/*.cpp",
        }

        defines {
            "ANGELSCRIPT_EXPORT"
        }

        filter "system:windows"
            filter "not architecture:x86"
                prelinkcommands {
                    'ml64.exe /c  /nologo /Fo $(IntDirFullPath)as_callfunc_x64_msvc_asm.obj /W3 /Zi /Ta $(ProjectDir)source\\as_callfunc_x64_msvc_asm.asm'
                }
        filter "system:windows"
            filter "not architecture:x86"
                postbuildcommands {
                    'lib $(TargetPath) $(IntDirFullPath)as_callfunc_x64_msvc_asm.obj /OUT:$(TargetPath)'
                }