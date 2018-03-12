/* DIR_NUM is defined in DirectionNumber.h which is included during shader compilation because #include is not supported for some fucking stupid reson@&#! */
const int NUM = DIR_NUM/4;

uniform highp mat4 transformationMatrix;
uniform highp mat4 projectionMatrix;
uniform mediump mat3 normalMatrix;
uniform highp vec3 light;

layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 amplitude[NUM];

out mediump vec3 transformedNormal;
out highp vec3 lightDirection;
out highp vec3 cameraDirection;
out highp vec4 pos;
out highp vec4 ampl[NUM];

float Ampl(int i){
  return amplitude[i/4][i%4];
}

void main() {
  highp vec3 normal = vec3(0.0,0.0,1.0);
  highp vec3 p = position.xyz/position.w;


  
  
  
  /* Transformed vertex position */
  highp vec4 transformedPosition4 = transformationMatrix*vec4(p.x,p.y,p.z,1);
  highp vec3 transformedPosition = transformedPosition4.xyz/transformedPosition4.w;

  /* Transformed normal vector */
  transformedNormal = normalMatrix*normal;

  /* Direction to the light */
  lightDirection = normalize(light - transformedPosition);

  /* Direction to the camera */
  cameraDirection = -transformedPosition;

  /* Transform the position */
  gl_Position = projectionMatrix*transformedPosition4;

  for(int i=0;i<NUM;i++){
    ampl[i] = amplitude[i];
  }
}