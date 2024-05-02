#include "llpch.h"
#include <Lulu.h>

class Sandbox : public Lulu::Application {
public:
	Sandbox() {}
	~Sandbox() {}
};

Lulu::Application* Lulu::CreateApplication()
{
	return new Sandbox();
}