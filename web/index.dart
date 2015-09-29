
library index;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

RenderLoop renderLoop = new RenderLoop();
ResourceManager resourceManager  = new ResourceManager();


class Rectangle extends Sprite {

  final Piano piano;
  final String note;
  final Sound sound;

  Rectangle() {

    // draw the key
    var bitmapData = resourceManager.getBitmapData("nishimura");
    var bitmap = new Bitmap(bitmapData);
    this.addChild(bitmap);

    /*
    var textColor = note.endsWith('#') ? Color.White : Color.Black;
    var textFormat = new TextFormat('Helvetica,Arial', 10, textColor, align:TextFormatAlign.CENTER);

    var textField = new TextField();
    textField.defaultTextFormat = textFormat;
    textField.text = note;
    textField.width = bitmapData.width;
    textField.height = 20;
    textField.mouseEnabled = false;
    textField.y = bitmapData.height - 20;
    addChild(textField);
    */
    // add event handlers
    this.useHandCursor = true;
    this.onMouseDown.listen(_keyDown);
    //this.onMouseOver.listen(_keyDown);
    this.onMouseUp.listen(_keyUp);
    //this.onMouseOut.listen(_keyUp);
    this.onMouseMove.listen(_keyMove);
    this.x = 100;
    this.y = 100;
  }

  bool down = false;
  MouseEvent e0;
  int x0;
  int y0;

  _keyDown(MouseEvent me) {
    print('Down');
    down = true;
    e0 = me;
    x0 = e0.stageX;
    y0 = e0.stageY;
  }

  _keyMove(MouseEvent me) {
    print('Move ${down} , ${me.stageX}:${me.stageY}');
    int x = me.stageX;
    int y = me.stageY;
    var dx = ( x0 - x );
    var dy = ( y0 - y );
    print('Move ${dx} : ${dy}');
    if(down) {
      this.x = this.x - dx;
      this.y = this.y - dy;
    }
  }

  _keyUp(MouseEvent me) {
    print('Up');
    down = false;
  }
}

void main() {

  StageXL.stageOptions.renderEngine = RenderEngine.WebGL;
  StageXL.stageOptions.backgroundColor = Color.Black;

  var stage = new Stage(html.querySelector('#stage'));
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  resourceManager.addBitmapData('nishimura','400011_s.jpg');

  resourceManager.load()
  .then((_) {
    print('Hello');
    stage.addChild(new Rectangle());
    //renderLoop.start();
  });
}