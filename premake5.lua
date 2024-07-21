workspace "Lulu"
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Lulu/Third-party/GLFW/include"
IncludeDir["Glad"] = "Lulu/Third-party/Glad/include"

include "Lulu/Third-party/GLFW" -- include the premake file from GLFW
include "Lulu/Third-party/Glad" -- include the premake file from GLAD

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
       "%{prj.name}/Third-party/spdlog/include",
       "%{IncludeDir.GLFW}",
       "%{IncludeDir.Glad}"
   }

   links
   {
      "GLFW",
      "Glad",
      "opengl32.lib",
      "dwmapi.lib"
   }

   filter "system:windows"
      cppdialect "C++17"
      staticruntime "On"
      systemversion "latest"

      defines
      { 
         "LL_PLATFORM_WINDOWS",
         "LL_BUILD_DLL",
         "GLFW_INCLUDE_NONE" --Glad load all gl headers so glfw should load none of them
      }

      postbuildcommands
      {
          ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/LuluSamples")
      }

   filter "configurations:Debug"
      defines { "LL_DEBUG" }
      buildoptions "/MDd"
      symbols "On"

   filter "configurations:Release"
      defines { "LL_RELEASE" }
      buildoptions "/MD"
      optimize "On"

   filter "configurations:Dist"
      defines { "LL_DIST" }
      buildoptions "/MD"
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
      buildoptions "/MDd"
      symbols "On"

   filter "configurations:Release"
      defines { "LL_RELEASE" }
      buildoptions "/MD"
      optimize "On"

   filter "configurations:Dist"
      defines { "LL_DIST" }
      buildoptions "/MD"
      optimize "On"