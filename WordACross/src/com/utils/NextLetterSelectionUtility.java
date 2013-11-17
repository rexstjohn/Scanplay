package com.utils;

import android.util.Log;
import com.models.LetterModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/30/11
 * Time: 1:35 PM
 */
public class NextLetterSelectionUtility
{

    //decides which letters to place in an incoming column
    public static int getRandomLetterIndex()
    {
        Random randomGenerator = new Random();
        int index = 999;
        int possibleIndex = 0;
        double rand;

        while(index == 999)
        {
           possibleIndex =  randomGenerator.nextInt(26);
           rand = Math.random();

            if(Alphabet.letterFrequency.get(Alphabet.chars.get(possibleIndex)) >= rand)
                index = possibleIndex;
        }

         return index;
    }
}
