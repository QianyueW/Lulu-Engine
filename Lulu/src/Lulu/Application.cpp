#include "Application.h"

#include "Events/ApplicationEvent.h"
#include "Log.h"

namespace Lulu {

Application::Application()
{
}

Application::~Application()
{
}

void Application::Run()
{
	WindowResizeEvent e(1280, 720);
	if (e.IsInCategory(EventCategoryApplication)) 
	{
		LL_WARN(e); // Warning log is in yellow
	}
	if (e.IsInCategory(EventCategoryInput))
	{
		LL_TRACE(e); // Trace log is in white
	}

	while (true);
}

}