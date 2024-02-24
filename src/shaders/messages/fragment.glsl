uniform vec3 iResolution;
uniform float iTime;
uniform float iTimeDelta;
uniform float iFrameRate;
uniform int iFrame;
uniform float iChannelTime[4];
uniform vec3 iChannelResolution[4];
uniform vec4 iMouse;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
uniform vec4 iDate;
uniform float iSampleRate;

#define C(x, y) length( cross( vec3( sin(x), sin(y), 1.5 ), D ) )

void mainImage(out vec4 c, vec2 f)
{
    float t = iTime;
	vec3  R = iResolution, 
          D = vec3(f - R.xy*.5, R.y*.2);
         
    c = C(0., 0.) *
             vec4( C( 0. ,  t+t ),
                   C( t - .5 , 0. ),
                   C( t*.5 - 1. , t - 2. ), 1 ) / dot(D,D);
                      
	c = exp(-c * c);
}

void main()
{
    vec4 color;
    mainImage(color, gl_FragCoord.xy);
    gl_FragColor = color;
}
