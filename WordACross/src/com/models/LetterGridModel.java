package com.models;

import org.cocos2d.nodes.*;
import org.cocos2d.opengl.CCTexture2D;
import org.cocos2d.types.CGPoint;
import org.cocos2d.types.CGRect;

import java.lang.reflect.Array;
import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: rexstjohn
 * Date: 7/23/11
 * Time: 11:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class LetterGridModel extends GameModel
{
    //how much padding on the bottom from the letter and the screen
    public static final int LETTER_Y_OFFSET = 65;

    public  static final int COLUMN_COUNT =  6;  //number of columns we create
    public  static final int COLUMN_LETTER_COUNT = 7; //how many letters in a column

    private ArrayList<LetterColumnModel> letterColumnModels;//all the letter columns
    private ArrayList<CCSpriteFrame> letterSprites;//all the sprites in the grid

    public LetterGridModel()
    {
        super();
        letterColumnModels = new ArrayList<LetterColumnModel>();
        letterSprites = new ArrayList<CCSpriteFrame>();

        //create the sprite cache we will need for creating the letters
        CCSpriteSheet alphabet = CCSpriteSheet.spriteSheet("alphabet.png");
        CCSprite letterSprite = new CCSprite(alphabet, CGRect.make(0f,0f,150.00f,150.00f));

        //
        int frameCount = 0;
        float spriteSheetHeight = 762; //pixel dimensions of the sprite sheet
        float spriteSheetWidth = 905;
        float spriteFrameHeight =  spriteSheetHeight /5;
        float spriteFrameWidth =  spriteSheetWidth / 6;
         CGPoint offset = CGPoint.make(0,0);

        //capture all of the sprite frames from our sprite sheet for later use
        for (float y = 0; y < 5; y++)
         {
            for (float x = 0; x < 6; x++)
            {
                CGRect textureRect = CGRect.make(x*spriteFrameWidth,y*spriteFrameHeight,spriteFrameWidth,spriteFrameHeight);
                CCTexture2D texture = letterSprite.getTexture();
                CCSpriteFrame frame = CCSpriteFrame.frame(texture,textureRect,offset);

                letterSprites.add(frame);
                frameCount++;

                if(frameCount == 26)break;
            }
        }
    }

    @Override
    public void destroy()
    {
        LetterColumnModel[] _letterColumns = letterColumnModels.toArray(new LetterColumnModel[letterColumnModels.size()]);

        for(LetterColumnModel letterColumnModel : _letterColumns)
        {
            letterColumnModel.destroy();
        }

        letterColumnModels.removeAll(letterColumnModels);
        letterSprites.removeAll(letterSprites);
        super.destroy();
    }

    //creates a new letter column and adds it to the grid
    public void addLetterColumnModel(LetterColumnModel _newColumn)
    {
        letterColumnModels.add(_newColumn);
    }

    public ArrayList<CCSpriteFrame> getLetterSprites() {
        return letterSprites;
    }

    public ArrayList<LetterModel> getAllLetters()
    {
        ArrayList<LetterModel> allLetters = new ArrayList<LetterModel>();

        for(LetterColumnModel _letterColumn : letterColumnModels )
        {
            for(LetterModel _letter : _letterColumn.getLetters())
            {
                allLetters.add(_letter);
            }
        }

        return  allLetters;
    }

    public int getSelectedCount()
    {
        int selectedCount = 0;

        for(LetterModel _letter : this.getAllLetters())
        {
            if(_letter.getSelected())
                selectedCount++;
        }

        return  selectedCount;
    }

    //blow up all the letters in each row
    public void clearAllLetters()
    {
        for(LetterColumnModel letterColumnModel : letterColumnModels)
        {
            letterColumnModel.clearAllLetters();
        }
    }
}
