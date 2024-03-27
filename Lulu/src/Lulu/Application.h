#pragma once

#include "Core.h"

namespace Lulu {
	class LULU_API Application
	{
	public:
		Application();
		virtual ~Application();
		void Run();
	};

	Application* CreateApplication();
}
