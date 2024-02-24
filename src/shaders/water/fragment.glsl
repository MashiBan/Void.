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

void mainImage1( out vec4 f, vec2 p )
{
    p = p / 2e3 - .2;

    float b = ceil(atan(p.x, p.y) * 6e2), h = cos(b), z = h / dot(p,p);
    // Multiply iTime by a smaller factor to reduce animation speed
    f = vec4(exp(fract(z + h * b + iTime * 0.05) * -1e2) / z);
}

void mainImage( out vec4 c, vec2 f )
{
    float t = iTime;
	vec3  R = iResolution, 
          D = vec3(f - R.xy*.5, R.y*.2);
         
    c = C(0., 0.) *
             vec4( C( 0. ,  t+t ),
                   C( t - .5 , 0. ),
                   C( t*.5 - 1. , t - 2. ), 1 ) / dot(D,D);
                      
	c = exp( -c * c);
}

void main() {
    // Set background color to black
    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);

    vec4 color1, color2;
    mainImage(gl_FragColor, gl_FragCoord.xy);
    mainImage1(color1, gl_FragCoord.xy);
    
    // Blend the two images together
    gl_FragColor += (gl_FragColor + color1) / 2.0;
}
