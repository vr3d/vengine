#version 430 core
#include AttributeLayout.glsl
#include Mesh3dUniforms.glsl

smooth out vec3 normal;
smooth out vec3 tangent;
smooth out vec3 positionWorldSpace;
smooth out vec3 positionModelSpace;
smooth out vec2 UV;
out flat int instanceId;
smooth out vec3 barycentric;

#include Bones.glsl

void main(){

    vec4 v = vec4(in_position,1);
    //vec4 n = vec4(in_normal,0);
	int vid = int(floor(mod(gl_VertexID, 3)));
	if(vid == 0)barycentric = vec3(1, 0, 0);
	if(vid == 1)barycentric = vec3(0, 1, 0);
	if(vid == 2)barycentric = vec3(0, 0, 1);

	tangent = (in_tangent);
	UV = vec2(in_uv.x, -in_uv.y);
    
    vec3 inorm = in_normal;
	
	if(Instances == 1){
        vec3 mspace = v.xyz;
        if(UseBoneSystem == 1){
            int bone = determineBone(mspace);
            mspace = applyBoneRotationChain(mspace, bone);
            inorm = applyBoneRotationChainNormal(inorm, bone);
        }
        v = vec4(mspace, 1);
		positionWorldSpace = (ModelMatrix * v).xyz;
		gl_Position = (ProjectionMatrix  * ViewMatrix) * vec4(positionWorldSpace, 1);	
	} else {
		gl_Position = (ProjectionMatrix  * ViewMatrix * ModelMatrixes[gl_InstanceID]) * v;	
		positionWorldSpace = (ModelMatrixes[gl_InstanceID] * v).xyz;
	}
	normal = inorm;
	
	instanceId = gl_InstanceID;

	positionModelSpace = v.xyz;	
	
}