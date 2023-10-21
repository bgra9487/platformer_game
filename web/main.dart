library webglapp;

import 'dart:math';
import 'dart:typed_data';
import 'dart:web_gl';
import 'dart:html';

import 'vector.dart';

String vertexShaderSrc = """
attribute vec2 position;
void main() {
  gl_Position = vec4(position, 0.0, 1.0);
}
""";

String fragmentShaderSrc = """
precision mediump float;
void main() {
  gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
""";

List<Vector2> verticesVec = [
  Vector2.polar(0.0, 1.0),
  Vector2.polar(2 * pi / 3, 1.0),
  Vector2.polar(4 * pi / 3, 1.0),
];

Float32List getVertices(List<Vector2> verticesVec) {
  return Float32List.fromList(verticesVec.expand((Vector2 v) => [v.x, v.y]).toList());
}

Float32List vertices = Float32List.fromList([
  -0.5, 0.5,
  0.0, -0.5,
  0.5, 0.5
]);

void initWebGl(RenderingContext gl, CanvasElement canvas) {
  gl.clearColor(0.0, 0.0, 0.0, 1.0);
  gl.viewport(0, 0, canvas.width ?? 500, canvas.height ?? 500);

  // Compile shaders and link
  Shader vs = gl.createShader(WebGL.VERTEX_SHADER);
  gl.shaderSource(vs, vertexShaderSrc);
  gl.compileShader(vs);

  Shader fs = gl.createShader(WebGL.FRAGMENT_SHADER);
  gl.shaderSource(fs, fragmentShaderSrc);
  gl.compileShader(fs);

  Program program = gl.createProgram();
  gl.attachShader(program, vs);
  gl.attachShader(program, fs);
  gl.linkProgram(program);
  gl.useProgram(program);

  /**
   * Check if shaders were compiled properly
   */
  if (gl.getShaderParameter(vs, WebGL.COMPILE_STATUS) == null) {
    print(gl.getShaderInfoLog(vs));
  }

  if (gl.getShaderParameter(fs, WebGL.COMPILE_STATUS) == null) {
    print(gl.getShaderInfoLog(fs));
  }

  if (gl.getProgramParameter(program, WebGL.LINK_STATUS) == null) {
    print(gl.getProgramInfoLog(program));
  }

  // Create vbo
  Buffer vbo = gl.createBuffer();
  gl.bindBuffer(WebGL.ARRAY_BUFFER, vbo);
  gl.bufferData(WebGL.ARRAY_BUFFER, getVertices(verticesVec), WebGL.STATIC_DRAW);

  int posAttrib = gl.getAttribLocation(program, "position");
  gl.enableVertexAttribArray(0);
  gl.vertexAttribPointer(posAttrib, 2, WebGL.FLOAT, false, 0, 0);
}

void renderRectangle(){
  CanvasElement canvas = document.getElementById('gameCanvas') as CanvasElement;
  RenderingContext? gl = canvas.getContext3d();

  render(num delta)
  {
    gl?.clear(WebGL.COLOR_BUFFER_BIT);

    // draw
    gl?.drawArrays(WebGL.TRIANGLES, 0, 3);

    // redraw when ready
    window.animationFrame.then(render);
  }


  if(gl == null)
  {
    print("Your browser doesn't seem to support WebGL.");
    return;
  }

  initWebGl(gl, canvas);
  window.animationFrame.then((render));
}


void main() {
  querySelector('#output')?.text = 'Your Dart app is running.';
  renderRectangle();
}
