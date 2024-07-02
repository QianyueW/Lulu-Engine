#include "llpch.h"
#include "Application.h"

#include "Events/ApplicationEvent.h"
#include "Log.h"

#include <GLFW/glfw3.h>

namespace Lulu {

#define BIND_EVENT_FN(x) std::bind(&Application::x, this, std::placeholders::_1)

Application::Application()
{
	m_Window = std::unique_ptr<Window>(Window::Create());
	m_Window->SetEventCallback(BIND_EVENT_FN(OnEvent));
}

Application::~Application()
{
}

void Application::OnEvent(Event& e)
{
	EventDispatcher dispatcher(e);
	dispatcher.Dispatch<WindowCloseEvent>(BIND_EVENT_FN(OnWindowClose));

	LL_CORE_TRACE(e);
}

bool Application::OnWindowClose(WindowCloseEvent& e)
{
	m_Running = false;
	return true;
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
		glClearColor(0, 1, 0, 1);
		glClear(GL_COLOR_BUFFER_BIT);
		m_Window->OnUpdate();
	}
}

}