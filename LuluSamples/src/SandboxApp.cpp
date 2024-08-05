#include "llpch.h"
#include <Lulu.h>

class ExampleLayer : public Lulu::Layer {
public:
    ExampleLayer() : Layer("Example") {

    }

    void OnUpdate() override {
        LL_INFO("ExampleLayer::Update");
    }

    void OnEvent(Lulu::Event& event) override {
        LL_TRACE("ExampleLayer::OnEvent {0}", event.ToString());
    }
};

class Sandbox : public Lulu::Application {
public:
	Sandbox() 
    {
        PushOverlay(new ExampleLayer());
        PushOverlay(new Lulu::ImGuiLayer());
    }
	~Sandbox() {}
};

Lulu::Application* Lulu::CreateApplication()
{
	return new Sandbox();
}

