workspace "Lulu"
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Lulu"
   location "Lulu"
   kind "SharedLib"
   language "C++"

   targetdir ("bin/" .. outputdir .. "/%{prj.name}")
   objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

   pchheader "llpch.h"
   pchsource "Lulu/src/llpch.cpp"

   files 
   { 
       "%{prj.name}/src/**.h",
       "%{prj.name}/src/**.cpp"
   }

   includedirs
   { 
       "%{prj.name}/src",
       "%{prj.name}/Third-party/spdlog/include"
   }

   filter "system:windows"
      cppdialect "C++17"
      staticruntime "On"
      systemversion "latest"

      defines { "LL_PLATFORM_WINDOWS","LL_BUILD_DLL" }

      postbuildcommands
      {
          ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/LuluSamples")
      }

   filter "configurations:Debug"
      defines { "LL_DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "LL_RELEASE" }
      optimize "On"

   filter "configurations:Dist"
      defines { "LL_DIST" }
      optimize "On"

project "LuluSamples"
   location "LuluSamples"
   kind "ConsoleApp"
   language "C++"
   targetdir ("bin/" .. outputdir .. "/%{prj.name}")
   objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

   files 
   { 
       "%{prj.name}/src/**.h",
       "%{prj.name}/src/**.cpp"
   }

   includedirs
   { 
       "Lulu/Third-party/spdlog/include",
       "Lulu/src"
   }

   links
   {
       "Lulu"
   }

   filter "system:windows"
      cppdialect "C++17"
      staticruntime "On"
      systemversion "latest"
      defines { "LL_PLATFORM_WINDOWS" }

   filter "configurations:Debug"
      defines { "LL_DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "LL_RELEASE" }
      optimize "On"

   filter "configurations:Dist"
      defines { "LL_DIST" }
      optimize "On"