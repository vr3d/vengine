#version 430 core

in vec2 UV;
#include Lighting.glsl
#include LogDepth.glsl
#define mPI (3.14159265)
#define mPI2 (2*3.14159265)
#define GOLDEN_RATIO (1.6180339)
out vec4 outColor;

layout(binding = 0) uniform sampler2D color;
layout(binding = 1) uniform sampler2D depth;
layout(binding = 2) uniform sampler2D fog;
layout(binding = 3) uniform sampler2D lightpoints;
layout(binding = 4) uniform sampler2D bloom;
layout(binding = 5) uniform sampler2D globalIllumination;

vec3 lookupFog(){
	vec3 outc = vec3(0);
	int counter = 0;
	for(float g = 0; g < mPI2 * 2; g+=GOLDEN_RATIO)
	{ 
		for(float g2 = 0; g2 < 6.0; g2+=1.0)
		{ 
			vec2 gauss = vec2(sin(g + g2)*ratio, cos(g + g2)) * (g2 * 0.005);
			vec3 color = texture(fog, UV + gauss).rgb;
			outc += color;
			counter++;
		}
	}
	return outc / counter;
}

vec3 lookupFogSimple(){
	return texture(fog, UV).rgb;
}

vec3 lookupGI(){
	vec3 outc = vec3(0);
	int counter = 0;
	for(float g = 0; g < mPI2 * 2; g+=GOLDEN_RATIO)
	{ 
		for(float g2 = 0; g2 < 3.0; g2+=1.0)
		{ 
			vec2 gauss = vec2(sin(g + g2)*ratio, cos(g + g2)) * (g2 * 0.005);
			vec3 color = texture(globalIllumination, UV + gauss).rgb;
			outc += color;
			counter++;
		}
	}
	return outc / counter * 3;
}

void main()
{
	vec3 color1 = texture(color, UV).rgb;
	color1 += lookupFog();
	color1 += texture(lightpoints, UV).rgb;
	color1 += texture(bloom, UV).rgb;
	color1 += lookupGI();
	
	
	gl_FragDepth = texture(depth, UV).r;
	
	
    outColor = vec4(color1, 1);
}