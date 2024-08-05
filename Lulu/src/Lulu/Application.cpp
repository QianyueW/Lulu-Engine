#include "llpch.h"
#include "Application.h"
#include "Events/Event.h"
#include "Events/ApplicationEvent.h"
#include "Log.h"

#include <Glad/glad.h>

namespace Lulu {

#define BIND_EVENT_FN(x) std::bind(&Application::x, this, std::placeholders::_1)

Application* Application::s_Instance = nullptr;

Application::Application()
{
	LL_CORE_ASSERT(!s_Instance, "Application already exists!");
	s_Instance = this;

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

	for (auto it = m_LayerStack.end(); it != m_LayerStack.begin();) {
		(*--it)->OnEvent(e);
		if (e.Handled) {
			break;
		}
	}
}

bool Application::OnWindowClose(WindowCloseEvent& e)
{
	m_Running = false;
	return true;
}

void Application::PushLayer(Layer* layer) 
{
	m_LayerStack.PushLayer(layer);
	layer->OnAttach();
}

void Application::PushOverlay(Layer* layer) 
{
	m_LayerStack.PushOverlay(layer);
	layer->OnAttach();
}

void Application::PopLayer(Layer* layer) 
{
	m_LayerStack.PopLayer(layer);
}

void Application::PopOverlay(Layer* layer) 
{
	m_LayerStack.PopOverlay(layer);
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
		for (Layer* layer : m_LayerStack)
		{
			layer->OnUpdate();
		}
		m_Window->OnUpdate();
	}
}

}