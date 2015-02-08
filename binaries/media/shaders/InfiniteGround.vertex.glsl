#version 430 core

layout(location = 0) in vec3 in_position;
layout(location = 1) in vec2 in_uv;
layout(location = 2) in vec3 in_normal;

uniform mat4 ModelMatrix;
uniform mat4 ViewMatrix;
uniform mat4 ProjectionMatrix;
uniform vec3 CameraPosition;
uniform float Time;

out vec4 positionWorldSpace;

void main(){

    vec4 v = vec4(in_position,1);
	mat4 mvp = ProjectionMatrix * ViewMatrix * ModelMatrix;
	positionWorldSpace = ModelMatrix * v;
    gl_Position = mvp * v;
}