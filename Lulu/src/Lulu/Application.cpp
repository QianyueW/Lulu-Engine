#include "llpch.h"
#include "Application.h"

#include "Events/ApplicationEvent.h"
#include "Log.h"

#include <GLFW/glfw3.h>

namespace Lulu {

Application::Application()
{
	m_Window = std::unique_ptr<Window>(Window::Create());
}

Application::~Application()
{
}

void Application::Run()
{
	//WindowResizeEvent e(1280, 720);
	//if (e.IsInCategory(EventCategoryApplication)) 
	//{
	//	LL_WARN(e); // Warning log is in yellow
	//}
	//if (e.IsInCategory(EventCategoryInput))
	//{
	//	LL_TRACE(e); // Trace log is in white
	//}

	while (m_Running)
	{
		glClearColor(1, 0, 1, 1);
		glClear(GL_COLOR_BUFFER_BIT);
		m_Window->OnUpdate();
	}
}

}