package com.models;

import com.events.SpriteWasDestroyedEvent;
import com.glue.EventBus;

import static org.cocos2d.config.ccMacros.CC_RADIANS_TO_DEGREES;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 3:22 PM
 *
 * arrows that appear on top of a letter selection series
 */
public class SelectionArrowModel extends GameSpriteModel
{
    private static final float ARROW_WIDTH = 20;
    private static final float ARROW_HEIGHT = 20;

    private LetterModel originLetter;  //letter from which the arrow originates
    private LetterModel targetLetter;  //lletter to which the arrow points

    public SelectionArrowModel(LetterModel _originLetter, LetterModel _targetLetter)
    {
        super(ARROW_WIDTH,ARROW_HEIGHT, "arrow.png");
        originLetter = _originLetter;
        targetLetter = _targetLetter;

        //set the rotation of the arrow
        float dx = (originLetter.getX() - targetLetter.sprite.getPosition().x );
        float dy = (originLetter.sprite.getPosition().y - targetLetter.sprite.getPosition().y );
        double angleRadians = -Math.atan2((double)dy, (double )dx);
        float angleDegrees = CC_RADIANS_TO_DEGREES((float )angleRadians);
        setRotation(angleDegrees - 180);

        //set the positionof the arrow
        setPosition(_originLetter.getPosition());
    }

     @Override
    public void destroy()
    {
        originLetter = null;
        targetLetter = null;
        super.destroy();
    }
}
