#pragma once

#ifdef LL_PLATFORM_WINDOWS

extern Lulu::Application* Lulu::CreateApplication();

int main(int argc, char** argv)
{
	auto app = Lulu::CreateApplication();
	app->Run();
	delete app;
}

#endif