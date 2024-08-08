workspace "Lulu"
   architecture "x64"
   startproject "LuluSamples"
   configurations { "Debug", "Release", "Dist" }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Lulu/Third-party/GLFW/include"
IncludeDir["Glad"] = "Lulu/Third-party/Glad/include"
IncludeDir["ImGui"] = "Lulu/Third-party/imgui"

group "Dependencies"
   include "Lulu/Third-party/GLFW" -- include the premake file from GLFW
   include "Lulu/Third-party/Glad" -- include the premake file from GLAD
   include "Lulu/Third-party/ImGui" 

project "Lulu"
   location "Lulu"
   kind "SharedLib"
   language "C++"
   staticruntime "off"

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
       "%{IncludeDir.Glad}",
       "%{IncludeDir.ImGui}",
   }

   links
   {
      "GLFW",
      "Glad",
      "ImGui",
      "opengl32.lib",
      "dwmapi.lib"
   }

   filter "system:windows"
      cppdialect "C++17"
      systemversion "latest"

      defines
      { 
         "LL_PLATFORM_WINDOWS",
         "LL_BUILD_DLL",
         "LL_ENABLE_ASSERTS",
         "GLFW_INCLUDE_NONE" --Glad load all gl headers so glfw should load none of them
      }

      postbuildcommands
      {
          ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/LuluSamples")
         --  ("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/LuluSamples/\"")
      }

   filter "configurations:Debug"
      defines { "LL_DEBUG" }
      runtime "Debug"
      symbols "On"

   filter "configurations:Release"
      defines { "LL_RELEASE" }
      runtime "Release"
      optimize "On"

   filter "configurations:Dist"
      defines { "LL_DIST" }
      runtime "Release"
      optimize "On"

project "LuluSamples"
   location "LuluSamples"
   kind "ConsoleApp"
   language "C++"
   staticruntime "off"
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
      systemversion "latest"
      defines { "LL_PLATFORM_WINDOWS" }

   filter "configurations:Debug"
      defines { "LL_DEBUG" }
      runtime "Debug"
      symbols "On"

   filter "configurations:Release"
      defines { "LL_RELEASE" }
      runtime "Release"
      optimize "On"

   filter "configurations:Dist"
      defines { "LL_DIST" }
      runtime "Release"
      optimize "On"