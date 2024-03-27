#pragma once

#ifdef LL_PLATFORM_WINDOWS
	#ifdef LL_BUILD_DLL	
		#define LULU_API __declspec(dllexport)
	#else
		#define LULU_API __declspec(dllimport)
	#endif
#else
	#error Lulu only supports Windows!
#endif