//
//  Shader.fsh
//  SceneKitStarter
//
//  Created by Rex St. John on 11/17/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
