// CONFIGURATION
const float DURATION = 0.15;               // How long the ripple animates (seconds)
const float MAX_SIZE = 0.05;             // Max radius in normalized coords (0.5 = 1/4 screen height)
const float RING_THICKNESS = 0.025;             // Ring width in normalized coords
const float CURSOR_WIDTH_CHANGE_THRESHOLD = 0.5; // Triggers ripple if cursor width changes by this fraction
vec4 COLOR = vec4(0.8, 0.7, 0.9, 1.0); // change to iCurrentCursorColor for your cursor's color
const float BLUR = 1.0;                    // Blur level in pixels
const float ANIMATION_START_OFFSET = 0.0;        // Start the ripple slightly progressed (0.0 - 1.0)


// Easing functions
float easeOutSine(float t) {
    return sin((t * 3.1415916) / 2.0);
}
float easeOutBack(float t) {
    const float c1 = 1.70158;
    const float c3 = c1 + 1.0;
    return 1.0 + c3 * pow(t - 1.0, 3.0) + c1 * pow(t - 1.0, 2.0);
}
// Pulse fade functions
float easeOutPulse(float t) {
    return t * (2.0 - t);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b){
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord){
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    // Normalization & setup (-1 to 1 coords)
    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    vec2 centerCC = currentCursor.xy - (currentCursor.zw * offsetFactor);

    float cellWidth = max(currentCursor.z, previousCursor.z); // width of the 'block' cursor
    
    // check for significant width change
    float widthChange = abs(currentCursor.z - previousCursor.z);
    float widthThresholdNorm = cellWidth * CURSOR_WIDTH_CHANGE_THRESHOLD;
    float isModeChange = step(widthThresholdNorm, widthChange);


    // ANIMATION
    float rippleProgress = (iTime - iTimeCursorChange) / DURATION + ANIMATION_START_OFFSET;
    // don't clamp yet; we need to know if it's > 1.0 (finished)
     float isAnimating = 1.0 - step(1.0, rippleProgress); // progress < 1.0 ? 1.0: 0.0
     
     if (isModeChange > 0.0 && isAnimating > 0.0) {
        // Apply easing to progress
        float easedProgress = easeOutSine(rippleProgress);

        // RIPPLE CALCULATION
        float rippleExpansion = easedProgress * MAX_SIZE;
        
        float fade = 1.0 - easeOutPulse(rippleProgress);
        // Calculate distance from frag to cursor center
        // float dist = distance(vu, centerCC);
        
        // float sdfRing = abs(dist - rippleExpansion) - RING_THICKNESS * 0.5;
        vec2 halfSizeCC = vec2(currentCursor.z, currentCursor.w) * 0.5 + vec2(rippleExpansion);
        float sdfRectRing = abs(getSdfRectangle(vu, centerCC, halfSizeCC)) - RING_THICKNESS * 0.5;
        // Antialias (1-pixel width in normalized coords)
        float antiAliasSize = normalize(vec2(BLUR, BLUR), 0.0).x;
        float ripple = (1.0 - smoothstep(-antiAliasSize, antiAliasSize, sdfRectRing)) * fade;

        // Apply ripple effect
        fragColor = mix(fragColor, COLOR, ripple * COLOR.a);
    }
    // else: do nothing, keep original fragColor
}
