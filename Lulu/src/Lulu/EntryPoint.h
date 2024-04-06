#pragma once

#ifdef LL_PLATFORM_WINDOWS

extern Lulu::Application* Lulu::CreateApplication();

int main(int argc, char** argv)
{
	Lulu::Log::Init();
	LL_CORE_WARN("Initialized Log!");
	int a = 5;
	LL_INFO("Hello! Var={0}", a);

	auto app = Lulu::CreateApplication();
	app->Run();
	delete app;
}

#endif